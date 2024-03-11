from pyquery import PyQuery

html = "<div class='definitions'> <div class='hom'><span class='gramGrp pos'>uncountable noun</span><div class='sense'> <div class='def'><span class='hi rend-b'>Anguish</span> is <a class='ref type-def' href='entry://great'>great</a> mental <a class='ref type-def' href='entry://suffering'>suffering</a> or physical pain. <span class='tips'><span class='lbl type-register'><span class='punctuation'> [</span>written<span class='punctuation'>]</span></span></span></div><div class='examples'><div class='cit'><span class='quote'> A cry of anguish burst from her lips.</span><span class='type-exa_sound'> <span class='exa_sound online' data-lang='en_GB' data-src-mp3='https://www.collinsdictionary.com/sounds/hwd_sounds/en_gb_exa_a_cry_of_anguish_burst_from_her_lips.mp3' onclick='new Audio(this.getAttribute('data-src-mp3')).play()'> </span></span></div><div class='cit'><span class='quote'> Mark looked at him in anguish.</span><span class='type-exa_sound'> <span class='exa_sound online' data-lang='en_GB' data-src-mp3='https://www.collinsdictionary.com/sounds/hwd_sounds/en_gb_exa_mark_looked_at_him_in_anguish.mp3' onclick='new Audio(this.getAttribute('data-src-mp3')).play()'> </span></span></div></div> <div class='thes'><b>Synonyms: </b> <a class='form ref' href='entry://suffering'>suffering</a>, <a class='form ref' href='entry://pain'>pain</a>, <a class='form ref' href='entry://torture'>torture</a>, <a class='form ref' href='entry://distress'>distress</a> &nbsp; </div> </div> </div> </div>"

pqdoc = PyQuery(html)
# explain_entrys = pqdoc('div > div.cobuild > div.definitions')
for a_tag in pqdoc("div.def > a"):
    # 创建一个新的<u>标签，并将<a>标签的文本内容赋值给它
    span_tag = PyQuery("<span></span>")
    span_tag.attr["class"] = a_tag.attrib["class"]
    span_tag.text(a_tag.text)
    pqdoc(a_tag).replaceWith(span_tag)
explain = str(pqdoc)
print(explain)
