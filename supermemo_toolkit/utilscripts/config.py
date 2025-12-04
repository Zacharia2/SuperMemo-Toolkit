import configparser
import json
import os


PROGRAM, SYSTEMS, SINGLE, VOICE, RATE, VOLUME = (
    "program",
    "systems",
    "single",
    "voice",
    "rate",
    "volume",
)


def get_config_dir():
    user_home_dir = os.path.expanduser("~")
    config_dir = os.path.join(user_home_dir, ".config", "supermemo_toolkit")
    return config_dir


def get_config():
    """返回smtk config，如果没有就创建空配置文件"""
    curr_conf_dict = dict()
    smtk_config_file_path = os.path.join(get_config_dir(), "conf.json")
    init_conf_dict = {PROGRAM: "null"}
    if not os.path.exists(get_config_dir()):
        os.makedirs(get_config_dir())
        # 创建空配置文件
        dump_config(smtk_config_file_path, init_conf_dict)
    elif not os.path.exists(smtk_config_file_path):
        # 创建空配置文件
        dump_config(smtk_config_file_path, init_conf_dict)
    else:
        curr_conf_dict = read_config(smtk_config_file_path)
    return curr_conf_dict


def read_config(conf_path: str) -> dict:
    """读取全部配置返回Dict"""
    with open(conf_path) as json_file:
        config = json.load(json_file)
    return config


def dump_config(conf_path: str, config: dict):
    """更新全部配置序列化Dict"""
    with open(conf_path, "w") as json_file:
        json.dump(config, json_file, indent=4)


def read_sm_system1(sm_location):
    sm_ini_path = os.path.join(sm_location, "bin", "supermemo.ini")
    config = configparser.ConfigParser()
    config.read(sm_ini_path)
    value = config.get("Systems", "System1")
    return value


def get_collection_primaryStorage(sm_location, col_name):
    """返回集合 col 主存储位置。

    Args:
        sm_location (_type_): sm 软件根目录
        col_name (_type_): 集合名称 (注意, 必须是英文名)

    Returns:
        _type_: 集合 col 主存储位置。
    """
    collection = os.path.join(sm_location, "systems", col_name, "elements")
    return collection


def get_collections_primaryStorage(sm_location):
    """
    collection_name: primaryStorage
    """

    collections = {}
    systems = os.path.join(sm_location, "systems")
    dir_list = os.listdir(systems)
    for current in dir_list:
        path = os.path.join(systems, current)
        # if os.path.isfile(path):
        if os.path.isdir(path) and current != ".git":
            collections.update({current: os.path.join(path, "elements")})

    return collections


def get_collections_primaryStorage_ui(sm_location):
    if not os.path.exists(sm_location):
        return []

    systems = os.path.join(sm_location, "systems")
    if not os.path.exists(systems) or not os.path.isdir(systems):
        return []

    collections = []

    for current in os.listdir(systems):
        path = os.path.join(systems, current)
        if os.path.isdir(path) and current != ".git":
            collections.append(current)

    return collections


# 获取config.ini文件路径
# def get_path():
#     current_path = os.path.abspath(__file__)
#     return os.path.join(
#         os.path.abspath(os.path.dirname(current_path) + os.path.sep), "config.ini"
#     )


# 定义读取配置文件的函数，分别读取section中的配置参数


# def get_config(config_file=get_path()):
#     parser = configparser.ConfigParser()
#     parser.read(config_file)
#     # 获取整型参数，按照key-value的形式保存
#     _conf_ints = [(key, int(value)) for key, value in parser.items("ints")]

#     # 获取字符型参数，按照key-value的形式保存
#     _conf_strings = [(key, str(value)) for key, value in parser.items("strings")]

#     # 返回一个字典对象，包含读取的参数
#     return dict(_conf_ints + _conf_strings)
