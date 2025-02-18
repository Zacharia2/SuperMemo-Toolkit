import html
from supermemo_toolkit.utilscripts.ankinet import invoke


class s2a:
    def __init__(self, qafile):
        self.qafile = qafile
        self.deckName = "TEQA Cards"
        self.modelName = "TEQA问答题"

    def setDeckName(self, deckName):
        self.deckName = deckName

    def __addNote(self, deckName: str, fields: dict):
        try:
            invoke(
                "addNote",
                note={
                    "deckName": deckName,
                    "modelName": self.modelName,
                    "fields": fields,
                    "options": {
                        "allowDuplicate": False,
                        "duplicateScope": "deck",
                        "duplicateScopeOptions": {
                            "deckName": deckName,
                            "checkChildren": False,
                            "checkAllModels": False,
                        },
                    },
                },
            )
        except Exception as e:
            print(f"{e}. ENum::{fields['ENum']}")

    def __createModel(self):
        modelNames = invoke("modelNames")
        if self.modelName not in modelNames:
            print(f"创建模型: {self.modelName}")
            invoke(
                "createModel",
                modelName=self.modelName,
                inOrderFields=["Front", "Back", "ENum"],
                css=".card {\n font-family: arial;\n font-size: 20px;\n text-align: center;\n color: black;\n background-color: white;\n}\n"
                + ".cloze {\n color: rgb(255, 0, 0);\n background-color: rgb(255, 255, 0);\n}",
                isCloze=False,
                cardTemplates=[
                    {
                        "Name": "卡片1",
                        "Front": "{{Front}}",
                        "Back": "{{FrontSide}}\n\n<hr id=answer>\n\n{{Back}}",
                    }
                ],
            )
        print(f"复用模型: {self.modelName}")

    def __selectedDesk(self, deckName: str):
        deckNames: str[list] = invoke("deckNames")
        if deckName not in deckNames:
            print(f"创建牌组: {deckName}")
            invoke("createDeck", deck=deckName)
        else:
            print(f"命中牌组: {deckName}")

    def __pre_proc(self, file: str) -> list:
        """输入TEQA文件, 输出list[qa dict]

        Args:
            file (str): TEQA文件路径

        Returns:
            list: list[dict_qa{}]
        """
        with open(file, "r", encoding="GB18030") as f:
            content = f.readlines()
        qa_list = []
        qa = []
        for line in content:
            # '<hr>\n' '\n'
            if line != "<hr>\n" and line != "\n":
                qa.append(line)
            elif len(qa) != 0:
                qa_list.append(qa)
                qa = []
        mqa_list = []
        for qa in qa_list:
            mqa = {}
            for field in qa:
                field: str = field.strip().split(": ", maxsplit=1)
                name, value = field
                mqa.update({name: html.unescape(value.strip())})
            mqa_list.append(mqa)
        return mqa_list

    def __creat_anki_card(self, mqa_list: list):
        # TEQA问答题, Front,Back,ENum
        # 行是检验知的最好方式，因为知行合一
        for num, qa in enumerate(mqa_list):
            print(
                f"添加卡片: {num + 1}/{len(mqa_list)} ENum::{qa['E']}", end="\033[K\r"
            )
            if "Q" in qa and "A" in qa and "E" in qa:
                self.__addNote(
                    self.deckName, {"Front": qa["Q"], "Back": qa["A"], "ENum": qa["E"]}
                )
            elif "Q" in qa and "A" in qa:
                self.__addNote(self.deckName, {"Front": qa["Q"], "Back": qa["A"]})
            elif "Q" in qa:
                self.__addNote(self.deckName, {"Front": qa["Q"]})
        print("\nDone!")

    def run(self):
        try:
            self.__createModel()
            self.__selectedDesk(self.deckName)
            qa_list = self.__pre_proc(self.qafile)
            self.__creat_anki_card(qa_list)
        except Exception as ex:
            print(ex)
