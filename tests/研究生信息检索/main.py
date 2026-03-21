from datetime import datetime
import time
import json
import os
from selenium import webdriver
from selenium.webdriver.edge.options import Options
from selenium.webdriver.edge.webdriver import WebDriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By

"""
我打算用了构建一个数据库。
这样就可以不用重复收集了。需要的时候直接调出来。



- 对象定义
  - 院校名称
    - 专业列表
      - 研究方向列表
    - 地区名称
      - 地区类别列表
    - 院校标签
    - 专业研究院地址。
      - 信息列表

"""

def count_pages(driver):
    return driver.execute_script(r"""
    var list = document.querySelectorAll("li.ivu-page-item");
    return Number(list[list.length - 1].textContent) - 1;
    """)


def one_page(driver):
    try:
        # 展开内容
        time.sleep(10)
        driver.execute_script(r"""
        var yx_info_list = document.getElementsByClassName("zy-item");
        for (let yx_info of yx_info_list) {
            var btn = yx_info.querySelector("a.show-more");
            if (btn && btn.text === "展开") btn.click();
        }
        """)

        # 收集整理资料。
        time.sleep(10)
        one_page = driver.execute_script(r"""
        var one_page = {}
        var yx_info_list = document.getElementsByClassName("zy-item");
        for (let yx_info of yx_info_list) {
            var zy_name = document.querySelector("div.zy-name").textContent.trim().split("\n")[0]
            var yx_name = yx_info.querySelector("div.yx-name").textContent;
            var yx_area = yx_info.querySelector("div.yx-area").textContent;
            var yx_tags = yx_info.querySelectorAll("div.yx-tag");
            var ivu_table_tbody = yx_info.querySelector("tbody.ivu-table-tbody")
            var 专业列表 = {}
            var tags = []
            专业列表[zy_name] = []
            for (const ivu_table_row of ivu_table_tbody.children) {
                ivu_table_column = ivu_table_row.children
                var 学习方式 = ivu_table_column[3].textContent.trim()
                if (学习方式 !== "全日制") continue
                var 院系所 = ivu_table_column[0].textContent.trim()
                var 研究方向 = ivu_table_column[4].textContent.trim()
                var 拟招人数 = ivu_table_column[8].querySelector("div.ivu-tooltip-content").textContent.trim()
                专业列表[zy_name].push({ "院系所": 院系所, "研究方向": 研究方向, "拟招人数": 拟招人数 })
            }
            for (const yx_tag of yx_tags) {
                tags.push(yx_tag.textContent)
            }
            one_page[yx_name] = { "院校地区": yx_area, "院校标签": tags, "专业": 专业列表 }
        }
        return one_page
        """)
    except Exception as e:
        print(e)
    return one_page


def r():
    # 读取数据库
    if not os.path.exists(dbfile):
        if not os.path.exists(os.path.dirname(dbfile)):
            os.makedirs(os.path.dirname(dbfile))
        with open(dbfile, "w+", encoding="utf-8") as f:
            f.write(r"{}")
    with open(dbfile, "r+", encoding="utf-8") as f:
        db: dict = json.loads(f.read())
    return db


def w(db):
    # 刷新数据库
    with open(dbfile, "w+", encoding="utf-8") as f:
        f.write(json.dumps(db, ensure_ascii=False))


def commit(d):
    db = r()
    db.update(d)
    w(db)


def to_csv():
    # 解析为表格。
    head = "学校名称,学校地区,目标专业,研究方向,院系所,拟招人数,院校标签"
    lines = [head]

    for k, v in r().items():
        for f in v["专业"][list(v["专业"].keys())[0]]:
            t = (
                ",".join(
                    [
                        k,
                        v["院校地区"],
                        list(v["专业"].keys())[0],
                        f["研究方向"].replace(",", "，"),
                        f["院系所"],
                        f["拟招人数"],
                        "、".join(v["院校标签"]),
                    ]
                )
                .replace("\r", "")
                .replace("\n", "、")
            )

            lines.append(t)
    result = "\r\n".join(lines)
    with open(f"{filename}.csv", "w+", encoding="utf-8", newline="") as f:
        f.write(result)


def main():
    global filename, dbfile
    # 连接浏览器
    edge_options = Options()
    edge_options.add_experimental_option("debuggerAddress", "localhost:9222")
    driver: WebDriver = webdriver.Edge(options=edge_options)  # type: ignore
    driver.implicitly_wait(10)
    # driver.get(
    # )
    # driver.switch_to.window(driver)
    # driver.switch_to.window(driver.window_handles[0])
    # print(f"标题: {driver.title}")
    # print(f"URL: {driver.current_url}")

    filename = driver.execute_script(r"""
    return document.querySelector("div.zy-name").textContent.trim().split("\n")[0]
    """)
    dbfile = f"./database/{datetime.now().year}-{datetime.now().month}/{filename}.json"

    # 更新内容
    count = count_pages(driver)
    for i in range(count + 1):
        print(f"正在处理第 {i + 1} 页")
        if (i + 1) != int(
            driver.execute_script(r"""
            return document.querySelector("li.ivu-page-item-active").textContent
            """)
        ):
            break

        commit(one_page(driver))

        # 点击下一页
        if i < count:
            next_btn = driver.find_element(By.CSS_SELECTOR, "li.ivu-page-next")
            actions = ActionChains(driver)
            actions.move_to_element(next_btn).click().perform()


if __name__ == "__main__":
    main()
    to_csv()
