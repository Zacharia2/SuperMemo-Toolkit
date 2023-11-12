import requests

# 网络异常示例
try:
    response = requests.get("http://example.com/api/data")
    # print(response.status_code)
    response.raise_for_status()
    data = response.json()
except requests.exceptions.ConnectionError as e:
    print("网络连接异常: ", e)
except requests.exceptions.Timeout as e:
    print("连接超时: ", e)
except requests.exceptions.RequestException as e:
    print("请求异常: ", e)
except requests.exceptions.HTTPError as e:
    print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
except ValueError as e:
    print("响应解析异常: ", e)

# 对data数据进行进一步校验，例如如果有统一 返回值结构。。。
