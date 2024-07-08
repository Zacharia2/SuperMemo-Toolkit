async function lookupWordMeaning(word) {
  var dictLinks = [
    {
      href: `https://dict.eudic.net/dicts/en/${word}`,
      text: "欧路",
    },
    {
      href: `https://www.youdao.com/result?word=${word}&lang=en`,
      text: "有道",
    },
    {
      href: `https://dict.cn/search?q=${word}`,
      text: "海词",
    },
    {
      href: `https://www.bing.com/dict/search?q=${word}&FORM=HDRSC6`,
      text: "必应",
    },
    {
      href: `https://fanyi.sogou.com/text?keyword=${word}&transfrom=en&transto=zh-CHS&model=general`,
      text: "搜狗",
    },
  ];
  const url = dictLinks[0]["href"]
  try {
    // 发送请求并等待响应
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const html = await response.text();
    const tempElement = document.createElement("div");
    tempElement.innerHTML = html;

    // 使用 document.querySelector 查询元素
    const selectedElement = tempElement.querySelector("#ExpFCChild > div.exp");

    // 处理查询到的元素
    if (selectedElement) {
      console.log(selectedElement);
      // 如果需要，可以将元素插入到实际的 DOM 中
      // document.body.appendChild(selectedElement);
    } else {
      console.log("Element not found");
    }
  } catch (error) {
    console.error("There was a problem with the fetch operation:", error);
  }
}

const meaning = await lookupWordMeaning("word");

// // 函数：为每个单词添加 <ruby> 注音
// async function addRubyAnnotations(text) {
//   const regex = /<span[^>]*>(.*?)<\/span>/g;
//   const replacedText = text.replace(regex, "A").trim(); // .trim() 移除字符串首尾的空白符
//   const words = replacedText.split(/\s+/); // 按 whitespace 分割字符串
//   console.log(array);
//   let annotatedText = "";

//   for (const word of words) {
//     // 获取单词的含义
//     const meaning = await lookupWordMeaning(word);
//     // 生成 <ruby> 标签
//     const rubyTag = `<ruby>${word}<rp>(</rp><rt>${meaning}</rt><rp>)</rp></ruby>`;
//     // 添加到 annotatedText
//     annotatedText += rubyTag + " ";
//   }

//   return annotatedText.trim();
// }

// // 使用示例
// async function exampleUsage() {
//   const text = 'a joint <span class="decorated_word">enterprise</span> between French and Japanese companies';
//   try {
//     const annotatedText = await addRubyAnnotations(text);
//     // 创建一个元素来显示注音文本
//     const container = document.createElement("div");
//     container.innerHTML = annotatedText;
//     document.body.appendChild(container);
//   } catch (error) {
//     console.error("Error adding ruby annotations:", error);
//   }
// }

// // 运行示例
// exampleUsage();
