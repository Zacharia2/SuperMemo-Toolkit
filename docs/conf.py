import configparser
import json
import os


def read_config(conf_path):
    """ "读取配置"""
    with open(conf_path) as json_file:
        config = json.load(json_file)
    return config


def update_config(conf_path, config):
    """ "更新配置"""
    with open(conf_path, "w") as json_file:
        json.dump(config, json_file, indent=4)
    return None


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


def get_collections_temp(collection_path):
    """给定集合 col 绝对路径, 返回集合的 temp 路径。

    Args:
        collection_path (_type_): drive:/path/sm/systems/col

    Returns:
        _type_: drive:/path/sm/systems/col/temp
    """
    return os.path.join(collection_path, "temp")
