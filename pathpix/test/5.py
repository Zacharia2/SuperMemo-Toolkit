import imghdr
import requests


# 判断链接是不是，是的话就并返回response。

url = "https://pic3.zhimg.com/80/v2-65717f51941a186087226ae65a274d72_720w.webp"


response = requests.get(url, stream=True)
content_type = response.headers.get("content-type")
filetype = imghdr.what(None, response.content)
# 文件头信息、文件内容。
if content_type and "image" in content_type:
    # 返回 content_type
    print() 
elif filetype is not None:
    # 返回具体类型 "image/" + filetype
    print()
else:
    print()


# file_extension = get_url_file_name_and_suffix(url)[1]