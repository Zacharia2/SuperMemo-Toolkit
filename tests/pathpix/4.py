import os
from urllib.parse import urlparse
from urllib.parse import unquote

# url = "http://photographs.500px.com/kyle/09-09-201315-47-571378756077.jpg"
# url = "https://img1.baidu.com/it/u=1845235267,872385921&fm=26&fmt=auto&gp=0.jpg"
url = "http://aliyuncs.com/ae-pub%2Fve%2FassetImgs%2F20210812190956358825_cover.asas.jpg?OSSAccessKeyId=LTAI5tGb2xU5dmgqu1HdxzpT&Expires=1628853132&Signature=8NVI4NCd2%2BxxwgzgnubLtlHiBTI%3D"


def get_url_file_suffix(url):
    parse_result = urlparse(url)
    file_name = os.path.basename(unquote(parse_result.path))
    file_suffix = file_name.split(".")[-1]
    # _, file_suffix = os.path.splitext(file_name)
    # print(file_name)
    # print(file_suffix)
    return file_suffix


get_url_file_suffix(url)
"""
ae-pub%2Fve%2FassetImgs%2F20210812190956358825_cover.jpg
.jpg
"""
