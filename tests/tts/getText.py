from pywinauto.application import Application

app = Application(backend="win32").connect(class_name="TElWind")
app.top_window().set_focus()
# 模拟 Ctrl+C 复制内容，内容为Source code。
app.top_window().type_keys("^c")
# 然后监听剪贴板，把需要的内容查找出来，然后读取后，在调用tts就可以阅读了。

text = """
Begin Element #1168
Source=d:\supermemo\systems\reading-and-review
Parent=1805
ParentTitle=绗簩绔?缇や紬鐨勬儏鎰熷拰閬撳痉瑙?
Priority=65.8935
Begin ElementInfo #1168
Title=锛?0锛夌兢浼楁潨鎾扮殑鍘嗗彶锛堜笂锛? 缇や綋鐨勮瘉璇嶅湪濡傛绋嬪害涓婅儗鍙涗簡浜嬪疄鐨勭湡鐩革紝浠ヨ嚦浜庢垜浠棤娉曞啀瀵硅繖涓笘鐣屼笂鍙戠敓杩囩殑浜嬫儏鍋氬嚭鍑嗙‘鐨勫垽鏂€? 杩欐牱鐪嬫潵锛屾棤璁哄彂鐢熻繃鎬庢牱鐨勫巻鍙蹭簨浠讹紝鎬讳細鍥犱负缇や綋鐨勪互璁逛紶璁硅€屽彉寰椾紬璇寸悍绾€傚綋鏃堕棿鎺ㄧЩ锛屽綋鍘嗗彶浼犳壙鍒伴渶瑕佽杞戒笅鏉ョ殑鍝竴鍒绘椂锛屽氨浼氭棭宸蹭抚澶变簡瀹冪殑鏈潵闈㈣矊銆傚儚杩欐牱鐨勫巻鍙茶璁拌浇涓嬫潵鐨勬椂鍊欙紝鎭愭€曞彧鑳芥槸涓€绉嶇函绮规兂璞＄殑浜х墿銆?.
Type=Topic
Status=Memorized
FirstGrade=8
Ordinal=2043.000000
Repetitions=2
Lapses=0
Interval=53
LastRepetition=05.09.25
AFactor=1.192
UFactor=1.205
ForgettingIndex=10
Reference=<br><br><hr SuperMemo><SuperMemoReference><H5 dir=ltr align=left><Font size="1" style="color: transparent">#SuperMemo Reference:</font><br><FONT class=reference>#Title: &#31532;&#20108;&#31456; &#32676;&#20247;&#30340;&#24773;&#24863;&#21644;&#36947;&#24503;&#35266;</FONT></SuperMemoReference>
SourceArticle=1805
End ElementInfo #1168
ElementColor=-16777211
AutoPlay=1
BackgroundImage=
BackgroundFile=
BackgroundStyle=Tile
Scaled=1
ReadPointComponent=0
ReadPointStart=0
ReadPointLength=0
ReadPointScrollTop=0
ComponentNo=1
Begin Component #1
Type=HTML
Cors=(100,200,9700,9300)
DisplayAt=255
Hyperlink=0
HTMName=绗簩绔?缇や紬鐨勬儏鎰熷拰閬撳痉瑙?:  锛?0锛夌兢浼楁潨鎾扮殑鍘嗗彶锛堜笂锛?缇や綋鐨勮瘉璇嶅湪濡傛绋嬪害涓婅儗鍙涗簡浜嬪疄鐨勭湡鐩革紝浠ヨ嚦浜庢垜浠棤娉曞啀瀵硅繖涓笘鐣屼笂鍙戠敓杩囩殑浜嬫儏鍋氬嚭鍑嗙‘鐨勫垽鏂€?杩欐牱鐪嬫潵锛屾棤璁哄彂鐢熻繃鎬庢牱鐨勫巻鍙蹭簨浠讹紝鎬讳細鍥犱负缇や綋鐨勪互璁逛紶璁硅€屽彉寰椾紬璇寸悍绾€傚綋鏃堕棿鎺ㄧЩ锛屽綋鍘嗗彶浼犳壙鍒伴渶瑕佽杞戒笅鏉ョ殑鍝竴鍒绘椂锛屽氨浼氭棭宸蹭抚澶变簡瀹冪殑鏈潵闈㈣矊銆傚儚杩欐牱鐨勫巻鍙茶璁拌浇涓嬫潵鐨勬椂鍊欙紝鎭愭€曞彧鑳芥槸涓€绉嶇函绮规兂璞＄殑浜х墿銆?杩欐牱鐨勫巻鍙蹭功绫嶏紝鍙槸瀵硅瀵熸湁璇殑浜嬪疄鎵€鍋氱殑鏃犳牴鎹殑璁拌堪锛屽苟涓旀贩鏉傜潃涓€浜涘鎬濊€冪粨鏋滅殑瑙ｉ噴銆?浜庢槸锛屾垜浠張鍙互寰楀埌涓€涓叏鏂扮粨璁猴細閭ｄ簺琚杞借繘鍙蹭功锛屼笟宸叉垚涓哄彶瀹炵殑鍘嗗彶浜嬩欢锛屼篃鏈繀鏄湁浠峰€肩殑浜х墿銆傝€岄偅浜涚殦棣栫┓缁忕殑鎵€璋撴櫤鑰咃紝涔熻繙闈炲儚浠栦滑鑷繁鎵€璇寸殑閭ｆ牱绉夌瑪鐩翠功銆?璁板綍杩欐牱鐨勮櫄鍋囧巻鍙诧紝鍑犱箮鏄湪铏氬害鍏夐槾銆傚亣濡傛病鏈夋枃瀛︿綔鍝佷繚鐣欎笅鏉ワ紝鍋囧娌℃湁闊充箰銆佺粯鐢讳竴鑴夌浉鎵匡紝鍋囧娌℃湁閭ｄ簺娴佷紶鍗冨勾鐨勪笉鏈戒綔鍝侊紝閭ｄ箞鎴戜滑鍙兘瀵硅繃鍘荤殑鏃朵唬鐨勭湡鐩镐竴鏃犳墍鐭ャ€?鎴戜滑涓嶄簡瑙ｈ但鎷夊厠鍒╃壒锛屼笉娓呮閲婅喀鐗熷凹鎴栫﹩缃曢粯寰风殑鐢熷钩锛屽叧浜庝粬浠紝鎴戜滑涓嶆浘鎷ユ湁杩囦竴鍙ョ湡瀹炵殑璁板綍銆傛墍鏈夎兘澶熸墦鍔ㄧ兢浼楃殑锛岃兘澶熷湪缇や紬鑼冨洿鍐呭緱浠ユ祦浼犲苟淇濈暀涓嬫潵鐨勶紝鍙槸杩欎簺浼熶汉澶т紬鍦ㄧ璇濅腑鐨勫舰璞°€?浠栦滑鐨勭敓骞冲浜庣兢浼楁潵璇存棤鍏崇揣瑕侊紝缇や綋鎯宠鐨勫彧鏄兘澶熸弧瓒充粬浠渶瑕佺殑銆佹墦鍔ㄤ粬浠績鐏电殑浼熶汉銆?浜庢槸锛屽叧浜庝粬浠殑璋庤█琚竴鍐嶇紪閫狅紝鐩村埌鍜屾垜浠粖鏃ユ墍鐭ョ殑褰㈣薄姣棤鍑哄叆涓烘銆?
HTMFile=d:\supermemo\systems\reading-and-review\elements\6\23\2038.HTM
TestElement=0
ReadOnly=0
FullHTML=1
Style=0
End Component #1
Begin RepHist #1168
ElNo=1168 Rep=2 Laps=0 Date=05.09.2025 Hour=21.492 Int=47 Grade=10 Priority=56.9422 Postpones=6
ElNo=1168 Rep=1 Laps=0 Date=20.07.2025 Hour=12.485 Int=0 Grade=10 Priority=17.6086
End RepHist #1168
End Element #1168
"""
