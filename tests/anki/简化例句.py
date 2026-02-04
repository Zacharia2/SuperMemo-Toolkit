import base64
import os
import re
from bs4 import BeautifulSoup
import edge_tts
from time import sleep
from collections import Counter
from supermemo_toolkit.utilscripts.ankinet import invoke
from openai import OpenAI
from zai import ZhipuAiClient
from readmdict import MDX

from supermemo_toolkit.utilscripts.ulils import makeNameSafe


Z_client = ZhipuAiClient(api_key="")

A_client = OpenAI(
    base_url="https://aihubmix.com/v1",
)


def check_word_wrap(text: str):
    """检查 <b> 标签是否完整包裹单词"""

    pattern = (
        r"(?P<before>.?)(?P<tag><b[^>]*>)(?P<content>.*?)(?P<endtag></b>)(?P<after>.?)"
    )
    results = []
    for match in re.finditer(pattern, text, re.DOTALL):
        before = match.group("before")
        after = match.group("after")

        # 判断是否完整包裹：
        # 前面要么为空，要么是非字母数字字符（空格、标点、行首）
        # 后面要么为空，要么是非字母数字字符（空格、标点、行尾）
        is_full = (not before or not before[-1].isalnum()) and (
            not after or not after[0].isalnum()
        )

        results.append(is_full)

    return all(results) if results else False


def word_count_regex(text: str):
    pattern = re.compile(r"[a-zA-Z]+(?:'[a-zA-Z]+)?(?:-[a-zA-Z]+)*")
    tokens = pattern.findall(text.lower())
    return Counter(tokens)


def Baidu_Text_transAPI(query: str):
    import requests
    import random
    from hashlib import md5

    query = query.strip().replace("<b>", "").replace("</b>", "")

    # Set your own appid/appkey.
    appid = "20220510001209900"
    appkey = "M2BPXqdbOA3niegw_UrC"

    # For list of language codes, please refer to `https://api.fanyi.baidu.com/doc/21`
    from_lang = "en"
    to_lang = "zh"

    endpoint = "https://fanyi-api.baidu.com"
    path = "/api/trans/vip/translate"
    url = endpoint + path

    # Generate salt and sign
    def make_md5(s, encoding="utf-8"):
        return md5(s.encode(encoding)).hexdigest()

    salt = random.randint(32768, 65536)
    sign = make_md5(appid + query + str(salt) + appkey)

    # Build request
    headers = {"Content-Type": "application/x-www-form-urlencoded"}
    payload = {
        "appid": appid,
        "q": query,
        "from": from_lang,
        "to": to_lang,
        "salt": salt,
        "sign": sign,
    }

    # Send request
    r = requests.post(url, params=payload, headers=headers)
    result = r.json()["trans_result"][0]["dst"]

    # Show response
    return result


def trans(text: str):
    completion = A_client.chat.completions.create(
        model="mimo-v2-flash-free",
        messages=[
            {
                "role": "system",
                "content": "你是一个专业的翻译助手，专门将英文句子准确翻译成中文。你的输出必须严格遵循以下规则："
                "1.  只输出翻译后的中文句子。"
                "2.  不添加任何额外说明、修饰或对话内容。"
                "3.  确保翻译准确、通顺，符合中文表达习惯。",
            },
            {"role": "user", "content": "请翻译以下英文句子：" + text},
        ],
        max_completion_tokens=1024,
        temperature=0.8,
        top_p=0.95,
        stream=False,
        stop=None,
        frequency_penalty=0,
        presence_penalty=0,
        extra_body={"thinking": {"type": "disabled"}},
    )
    result: str = completion.choices[0].message.content or ""
    return result.strip()


def get_st(word: str):
    response = Z_client.chat.completions.create(
        model="glm-4.7-flash",
        messages=[
            {
                "role": "system",
                "content": "你是一个英语造句助手。请根据用户输入的任意单词的主要的意思，使用指定的单词表中的词汇来造句。"
                "**单词表范围：** time,morning,afternoon,noon,evening,night,tonight,today,tomorrow,yesterday,weekend,month,year,season,spring,autumn,winter,day,date,moment,period,history,future,birthday,holiday,festival,schedule,age,weather,rain,snow,wind,cloud,nature,mountain,air,light,water,fire,ice,smoke,heat,ground,sky,river,field,forest,sea,stone,star,plant,grass,tree,crop,animal,bird,cat,dog,horse,rabbit,elephant,bear,tiger,lion,bull,cow,pig,chicken,fish,sheep,monkey,snake,reptile,insect,bee,butterfly,spider,bacteria,place,hospital,restaurant,hotel,university,factory,jail,zoo,park,school,store,club,bar,court,market,town,village,city,organization,company,charity,sound,voice,noise,music,food,egg,meat,steak,bread,cake,dessert,soup,sandwich,noodle,pie,chocolate,sauce,meal,breakfast,lunch,dinner,vegetable,potato,tomato,carrot,lettuce,bean,fruit,apple,orange,banana,ingredient,oil,sugar,salt,butter,cream,drink,coffee,milk,tea,juice,beer,wine,alcohol,nutrient,mineral,vitamin,protein,disease,fever,flu,cancer,house,office,room,floor,wall,window,door,roof,kitchen,furniture,bed,chair,desk,table,seat,couch,clothes,shirt,shoes,cap,hat,coat,dress,pants,uniform,suits,underwear,pocket,jeans,button,zip,sock,jewelry,diamond,ring,cosmetics,perfume,lipstick,powder,transport,traffic,bicycle,ship,boat,plane,train,vehicle,motorcycle,bus,car,truck,brake,engine,gear,tire,wheel,road,street,bridge,station,device,lock,key,bell,scale,tap,equipment,shower,radio,telephone,camera,computer,TV,fridge,video,container,box,cup,dish,plate,bowl,basket,tub,sink,pot,pan,material,cloth,paper,glass,plastic,gold,paint,chemical,toy,brush,mirror,chain,board,handle,cartoon,bottle,wood,clock,knife,pen,book,album,menu,card,envelope,ticket,pipe,tube,wire,belt,web,film,screen,gift,channel,alarm,electricity,towel,carpet,tool,junk,fork,spoon,medicine,drug,pill,couple,double,load,pack,lot,unit,meter,inch,pound,gram,piece,thing,issue,matter,stuff,object,event,parent,daughter,son,father,mother,brother,sister,husband,wife,uncle,aunt,grandfather,grandmother,role,kid,child,baby,boy,girl,man,woman,friend,lady,gentleman,boss,customer,student,neighbor,person,volunteer,fool,sir,madam,job,doctor,nurse,professor,lawyer,engineer,teacher,coach,guard,judge,group,people,class,team,human,staff,society,generation,army,government,family,words,topic,subject,joke,question,suggestion,instruction,permission,document,story,report,novel,note,text,letter,email,blog,list,menu,rule,law,grammar,principle,information,message,news,update,notice,fact,detail,evidence,clue,background,data,sign,knowledge,state,condition,environment,situation,mess,balance,peace,emergency,chance,opportunity,act,exercise,practice,test,experiment,lesson,bath,security,attention,focus,step,education,advertisement,treatment,trick,habit,service,business,homework,job,task,project,challenge,duty,responsibility,fault,performance,concert,opera,drama,study,math,art,science,philosophy,psychology,arrangement,deal,insurance,account,engagement,occasion,meeting,interview,party,picnic,wedding,funeral,barbecue,ceremony,money,profit,income,salary,loan,cash,cost,credit,deposit,price,tax,bill,budget,activity,game,discipline,crime,trade,economy,politics,war,trip,fashion,industry,sports,soccer,football,golf,basketball,race,thought,idea,view,theory,religion,plan,strategy,policy,program,network,internet,series,career,system,language,transport,favor,privilege,mistake,risk,advantage,benefit,problem,trouble,surprise,secret,award,prize,diet,property,option,case,example,sample,score,limit,experience,effort,energy,figure,part,side,edge,base,core,head,eye,ear,face,nose,foot,mouth,tooth,tongue,neck,shoulder,breast,chest,stomach,arm,hand,finger,nail,leg,knee,throat,brain,heart,lung,muscle,bone,nerve,hair,skin,blood,sweat,mind,spirit,soul,emotion,feeling,shame,stress,respect,desire,pain,sense,strength,force,power,authority,ability,sight,intelligence,memory,skill,tail,wing,flower,leaf,root,branch,whole,rest,half,shape,appearance,size,space,position,point,line,end,bottom,middle,top,front,back,center,corner,left,right,direction,east,west,north,south,quality,feature,character,personality,color,weight,tone,material,structure,amount,number,measurement,distance,volume,angle,temperature,level,degree,grade,rank,standard,rate,speed,percentage,kind,type,form,way,behavior,mood,logic,tradition,culture,style,pattern,relation,manner,cause,reason,source,excuse,factor,purpose,goal,effect,result,course,process,be,go,come,make,have,get,give,take,put,lay,place,bring,send,hold,keep,stay,hang,settle,cover,support,mix,switch,link,join,connect,stick,tie,meet,cross,move,shift,pass,raise,lift,rise,drop,fall,follow,lead,carry,bounce,roll,shake,screw,run,rush,hurry,touch,hit,knock,crash,throw,rub,pull,push,draw,press,open,close,shut,fit,enter,fill,pump,spill,spray,clean,clear,wipe,leave,quit,arrive,reach,fix,set,begin,start,happen,finish,stop,turn,break,crack,split,tear,divide,cut,bend,fold,twist,stretch,spread,grow,look,see,listen,hear,say,speak,talk,tell,ask,think,believe,know,like,love,do,become,seem,feel,sound,smell,taste,find,watch,observe,ignore,search,show,agree,cancel,let,allow,claim,warn,introduce,explain,express,confirm,beg,charge,order,argue,blame,praise,encourage,complain,promise,insist,shout,threat,answer,call,count,pronounce,consider,guess,deserve,offer,doubt,suspect,trust,forget,remember,imagine,mean,learn,understand,wonder,decide,try,want,hope,wish,expect,will,shall,should,may,might,can,must,dare,need,impress,attract,enjoy,suffer,appreciate,care,hate,worry,thank,welcome,bless,thrill,freak,shock,bother,annoy,disturb,die,live,burn,boil,dance,ride,lie,climb,beat,hug,sit,stand,walk,kick,jump,skip,smile,laugh,cry,eat,kiss,suck,lick,blow,cough,sing,breathe,bleed,sleep,wake,relax,hurt,injure,cure,inject,cook,bake,fry,drive,measure,wear,wash,tape,record,post,travel,screw,dig,hide,pack,mark,buy,sell,shop,pay,spend,waste,invite,rent,fight,kill,steal,cheat,invest,rob,wait,marry,divorce,borrow,lend,owe,vote,bet,celebrate,play,pretend,help,direct,entertain,interrupt,distract,design,build,invent,copy,prepare,organize,manage,handle,treat,control,use,apply,save,choose,accept,pick,collect,win,fail,miss,lose,check,examine,compare,solve,analyze,skate,swim,fly,shoot,work,interview,hire,fire,compete,retire,read,write,spell,translate,match,qualify,equal,share,include,separate,belong,depend,involve,change,develop,improve,reduce,add,promote,damage,spoil,ruin,affect,attack,big,huge,little,small,medium,high,low,long,short,tall,deep,shallow,thick,thin,fat,slim,narrow,wide,heavy,light,straight,curved,flat,round,square,near,far,full,empty,blank,bare,dirty,new,fresh,extra,only,single,poor,rich,slight,total,hard,soft,tough,tender,smooth,rough,sharp,blunt,fresh,raw,pure,plain,even,strong,weak,tight,loose,firm,tense,liquid,gas,solid,hot,warm,cold,cool,dry,wet,bright,dark,dull,sweet,bitter,delicious,sour,spicy,loud,quiet,young,old,hungry,ill,sick,tired,blind,sore,born,pregnant,alive,busy,violent,wild,beautiful,ugly,sexy,smart,clever,stupid,confused,awake,asleep,familiar,patient,polite,lazy,honest,rude,brave,aggressive,interested,curious,proud,sure,confident,happy,glad,sad,upset,sorry,guilty,calm,afraid,angry,crazy,mad,excited,bored,disappointed,jealous,lonely,easy,hard,difficult,late,due,urgent,efficient,possible,available,dangerous,safe,wrong,strict,correct,proper,lucky,fair,successful,good,nice,fine,great,perfect,wonderful,amazing,excellent,bad,terrible,awful,real,TRUE,FALSE,fake,complete,exact,specific,complicated,simple,fun,horrible,weird,strange,comfortable,incredible,gross,special,regular,same,different,typical,normal,common,general,popular,average,particular,own,serious,causal,important,main,formal,professional,necessary,free,relative,legal,physical,mental,local,native,international,cheap,expensive,separate,public,worth,across,along,past,over,up,down,through,on,off,in,out,against,from,to,toward,for,about,at,by,beside,before,after,behind,between,around,beyond,under,above,below,outside,inside,within,of,with,without,during,since,till,instead,of,than,as,besides,among,except,including,according,to,despite,per,now,early,just,then,recently,ago,already,yet,ever,never,forever,here,there,away,forth,apart,together,aside,extra,alone,quite,much,very,well,extremely,almost,enough,actually,especially,absolutely,certainly,fast,slow,soon,suddenly,immediately,gradually,again,often,usually,always,finally,eventually,otherwise,probably,perhaps,maybe,also,too,either,neither,else,when,where,how,why,what,because,but,though,and,if,unless,except,while,or,whether,last,next,all,any,some,both,each,either,neither,every,few,many,much,this,that,these,those,another,such,I,you,he,she,we,they,it,which,who,a,an,the,bye,hello,no,yes,pardon,please,wow,damn,Mr,Ms,zero,one,two,three,four,five,six,seven,eight,nine,ten,hundred,thousand,million,billion"
                "**规则：**"
                "1. 只能使用上述单词表中的单词来造句"
                "2. 用户输入一个单词，你需要将单词用在一个句子中，并且不能改变单词的形式（如时态、单复数等）"
                "3. 句子应语法正确、自然通顺，只能使用简单句，句子长度应尽量简短，不应使用复合句及复杂句。"
                "**输出格式：**"
                "每次生成一个句子，不要包含任何标记语言，严格按以下格式输出："
                "例句：【英语句子】",
            },
            {"role": "user", "content": word},
        ],
        thinking={
            "type": "disabled",  # 启用深度思考模式
        },
        max_tokens=256,  # 最大输出 tokens
        temperature=1,  # 控制输出的随机性
        stream=False,
        stop=None,
    )
    result: str = response.choices[0].message.content.strip() or ""
    sentence = result.replace("例句：", "")
    sentence = sentence.translate(str.maketrans("", "", "【】*[]"))
    return sentence


def u_mdx(path: str):
    mdx = MDX(path)
    headwords = [*mdx]  # 单词名列表
    items = [*mdx.items()]  # 释义html源码列表
    if len(headwords) == len(items):
        print(f"加载成功：共{len(headwords)}条")
    else:
        print(f"【ERROR】加载失败{len(headwords)}，{len(items)}")
    return headwords, items


# note_id_list = invoke("findNotes", query="deck:26意境语义红宝石")
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     order_word: str = fields["order"]["value"]
#     # wdbj: str = fields["例句"]["value"]
#     if "updated_by_mimo" in tags:
#         continue
#     while True:
#         try:
#             sentence: str = get_st(order_word)
#             sleep(2)  # 限频
#             while (
#                 order_word.lower() not in sentence.lower()
#                 or word_count_regex(sentence.lower()).total() >= 12
#             ):
#                 print("retry for order:", order_word)
#                 sentence = get_st(order_word)
#                 sleep(2)  # 限频
#         except Exception as e:
#             print("Error occurred for order:", order_word, "Error:", str(e))
#         else:
#             break
#     sentence = sentence.replace(f"{order_word}", f"<b>{order_word}</b>")
#     invoke(
#         "updateNote",
#         note={
#             "id": noteId,
#             "fields": {
#                 "例句": sentence,
#             },
#             "tags": ["updated_by_mimo"],
#         },
#     )
#     print(f"{index + 1}/{len(notesInfo)}::{sentence}")


# note_id_list = invoke("findNotes", query="deck:26意境语义红宝石")
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     order_word: str = fields["orderKey"]["value"]
#     lj: str = fields["例句"]["value"]
#     if len(fields["例句音频U"]["value"]) != 0:
#         continue
#     lj_stripped = lj.strip().replace("<b>", "").replace("</b>", "")
#     file_name = makeNameSafe(lj_stripped).replace(".", "") + ".mp3"
#     communicate = edge_tts.Communicate(
#         text=lj_stripped, voice="en-US-ChristopherNeural"
#     )  # en-US-EricNeural
#     buffer = bytearray()
#     for chunk in communicate.stream_sync():
#         if chunk["type"] == "audio":
#             buffer.extend(chunk["data"])
#     file_data = base64.b64encode(bytes(buffer)).decode()
#     if file_name != "" and file_data != "":
#         result_filename = invoke("storeMediaFile", filename=file_name, data=file_data)
#         if result_filename:
#             sleep(2)  # 限频
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {
#                         "例句音频U": f"{result_filename}",
#                         "例句音频S": f"[sound:{result_filename}]",
#                     },
#                 },
#             )
#             print(f"{index + 1}/{len(notesInfo)}::{result_filename}")


# headwords, items = u_mdx("c:/Users/Snowy/Desktop/OLCC.mdx")
# anki_word = "attitude"
# note_id_list = invoke("findNotes", query="deck:26意境语义红宝石")
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     anki_word: str = fields["order"]["value"]
#     if anki_word.encode() in headwords:
#         word, html = items[headwords.index(anki_word.encode())]
#         word, html = word.decode(), html.decode()
#         soup = BeautifulSoup(html, "html.parser")
#         # 直接找第一个br标签
#         first_br = soup.find("br")
#         if first_br:
#             # 找br后面的font中的b标签
#             target_b = first_br.find_next_sibling("font").find("b")
#             if target_b:
#                 text = target_b.get_text(strip=True)
#                 # print("提取结果:", text)
#                 if fields["语音音节"]["value"] == "":
#                     invoke(
#                         "updateNote",
#                         note={
#                             "id": noteId,
#                             "fields": {
#                                 "语音音节": text,
#                             },
#                         },
#                     )
#                     print(f"{index + 1}/{len(notesInfo)}::{text}::{anki_word}")


# note_id_list = invoke("findNotes", query="deck:26意境语义红宝石")
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     order_word: str = fields["order"]["value"]
#     lj: str = fields["例句"]["value"]
#     fy: str = Baidu_Text_transAPI(lj)
#     if "fy_added" in tags:
#         continue
#     invoke(
#         "updateNote",
#         note={
#             "id": noteId,
#             "fields": {
#                 "例句翻译": fy,
#             },
#             "tags": ["fy_added"],
#         },
#     )
#     print(f"{index + 1}/{len(notesInfo)}::{fy}")


# headwords, items = u_mdx(
#     "D:\\Software\\GoldenDict-ng\\dicts\\ode_glance\\ode_glance.mdx"
# )
# note_id_list = invoke("findNotes", query="deck:26意境语义红宝石")
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     order_word: str = fields["order"]["value"]
#     yyyj: str = fields["语音音节"]["value"]
#     if len(yyyj.strip()) == 0:
#         if order_word.encode() in headwords:
#             word, html = items[headwords.index(order_word.encode())]
#             word, html = word.decode(), html.decode()
#             soup = BeautifulSoup(html, "html.parser")
#             spans = soup.select(
#                 "body > folderglance > halffolder.karxUS > div > header > h2 > span"
#             )
#             if spans:
#                 # spans
#                 syllable = spans[0].attrs["syllable"]
#                 invoke(
#                     "updateNote",
#                     note={
#                         "id": noteId,
#                         "fields": {"语音音节": syllable},
#                     },
#                 )
#                 print(f"{index + 1}/{len(notesInfo)}::{syllable}")


# word_1368 = dict()
# note_id_list1 = invoke("findNotes", query="deck:1368个单词就够了")
# notesInfo1 = invoke("notesInfo", notes=note_id_list1)
# for index, noteInfo in enumerate(notesInfo1):
#     cards = noteInfo["cards"]
#     fields = noteInfo["fields"]
#     deckName: dict = invoke("getDecks", cards=cards)
#     word_1368.update({fields["单词"]["value"]: list(deckName.keys())[0]})


# note_id_list2 = invoke("findNotes", query="deck:26意境语义红宝石")
# notesInfo2 = invoke("notesInfo", notes=note_id_list2)
# for index, noteInfo in enumerate(notesInfo2):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     order_word: str = fields["orderKey"]["value"]
#     if order_word in word_1368:
#         c = word_1368.get(order_word)
#         invoke(
#             "updateNote",
#             note={
#                 "id": noteId,
#                 "fields": {"1368词类树": c},
#             },
#         )
#         print(f"{index + 1}/{len(notesInfo2)}::{order_word} in 1368词类树")
