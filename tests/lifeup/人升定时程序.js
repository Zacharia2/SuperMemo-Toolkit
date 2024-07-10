const itemInfo = [
    { name: "自由券兑换券" },
    { name: "游戏兑换券" },
    { name: "抖音兑换券" },
    { name: "微博兑换券" },
    { name: "小红书兑换券" },
    { name: "b站兑换券" },
    { name: "知乎兑换券" },
];

function getFormattedDate(date) {
    let year = date.getFullYear();
    let month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份从0开始，所以需要加1
    let day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
}

function isHoliday(date) {
    // 使用中国节假日API
    const apiUrl = 'https://timor.tech/api/holiday/info/' + date;

    try {
        let res = http.get(apiUrl, {
            headers: {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
            }
        });
        if (res.statusCode != 200) {
            console.error('请求失败，状态码: ' + res.statusCode);
            return false;
        }
        
        let data = res.body.string();
        let json = JSON.parse(data);

        console.log(data);

        if (json && json.type && (json.type.type === 1 || json.type.type === 2)) {
            return true; // 该日期是休息日
        } else {
            return false; // 该日期不是休息日
        }
    } catch (error) {
        console.error('请求过程中出现错误: ' + error);
        return false;
    }
}

// 定义一个函数来调用API
function callApi(str) {
    let intent = app.intent({
        action: "VIEW",
        data: str,
        flags: ["activity_new_task"]
    });

    console.log("Starting activity with intent: " + intent.toUri(0));
    context.startActivity(intent);
}

function resetItem(itemName) {
    console.log("重置\"" + itemName + "\"");
    callApi("lifeup://api/item?name=" + itemName + "&own_number=0&own_number_type=absolute");
}

function addItem(itemName, number) {
    console.log("赠送\"" + itemName + "\" * " + number);
    callApi("lifeup://api/item?name=" + itemName + "&own_number=" + number + "&own_number_type=relative");
}

itemInfo.forEach(item => {
    resetItem(item.name);
});

let currentDate = new Date();
let formattedDate = getFormattedDate(currentDate);

if (isHoliday(formattedDate)) {
    addItem("休息券", 12);
} else {
    resetItem("休息券");
}