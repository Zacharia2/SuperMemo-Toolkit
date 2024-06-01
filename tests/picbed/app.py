import os
import sys
from flask import (
    Flask,
    request,
    jsonify,
)
from werkzeug.utils import secure_filename
from flask import send_from_directory
import random
import time

sys.path.insert(0, os.path.normpath(sys.path[0] + "/../../"))
from supermemo_toolkit.utilscripts import config  # noqa: E402


# 配置设置
cf = config.get_config()

# 允许上传的文件扩展名
allowed_extensions = {"txt", "pdf", "png", "jpg", "jpeg", "gif"}

# 图片存储路径
upload_folder = os.path.join(os.getcwd(), "pics")

# 初始化 Flask 应用
app = Flask(__name__, instance_relative_config=True)


def allowed_file(filename):
    """检查文件是否具有允许的扩展名。"""
    return "." in filename and filename.rsplit(".", 1)[1].lower() in allowed_extensions


@app.route("/", methods=["POST", "GET"])
def upload_file():
    """上传文件的路由。"""
    if request.method == "POST":
        file = request.files.get("file")

        # 文件验证
        if not file or file.filename == "":
            # 返回 404 错误，表示文件未上传
            response = jsonify(message="文件未上传")
            response.status_code = 404
            return response

        if not allowed_file(file.filename):
            # 返回 404 错误，表示不支持的文件类型
            response = jsonify(message="文件类型不支持")
            response.status_code = 404
            return response

        # 保存文件
        filename = f"{int(time.time())}{random.randint(1, 99999)}{secure_filename(str(random.randint(1, 7887)) + file.filename)}"
        file_path = file.save(os.path.join(upload_folder, filename))
        print(file_path)

        # 获取服务器地址和端口
        server_address = f"{app.config['running_domain']}:{app.config['running_port']}"

        # 构建可以在浏览器中访问的地址
        file_url = f"http://{server_address}/uploads/{filename}"

        # 返回成功的 JSON 消息包括文件可访问的地址
        response = jsonify(message="文件上传成功", file_url=file_url)
        response.status_code = 200
        return response


@app.route("/uploads/<filename>")
def uploaded_file(filename):
    """
    用于提供已上传文件的路由。

    :param filename: 从URL中获取的文件名。
    :return: 使用 send_from_directory 函数从指定目录发送文件。
    """
    # 从配置的上传文件夹中发送文件
    return send_from_directory(app.config["UPLOAD_FOLDER"], filename)


if __name__ == "__main__":
    # 配置应用的上传文件夹路径
    # 配置应用运行的域名
    # 配置应用运行的端口
    # 设置上传文件的最大内容长度限制
    app.config["UPLOAD_FOLDER"] = upload_folder
    app.config["running_domain"] = cf["running_domain"]
    app.config["running_port"] = cf["port"]
    app.config["MAX_CONTENT_LENGTH"] = 1024 * 1024 * int(cf["max_length"])

    # 确保实例文件夹存在
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass  # 如果文件夹已存在，则无需再次创建

    # 尝试创建上传文件夹，如果尚不存在
    try:
        os.mkdir(upload_folder)
    except Exception:
        pass  # 如果文件夹已存在或有其他错误，不做处理

    # 运行 Flask 应用
    # debug=False 表示在非调试模式下运行
    # host 和 port 设置了应用的访问域名和端口
    app.run(
        debug=False, host=app.config["running_domain"], port=app.config["running_port"]
    )
