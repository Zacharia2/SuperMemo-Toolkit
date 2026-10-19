import configparser
import json
import os
from pathlib import Path

PROGRAM, SYSTEMS, KNOS, VOICE, RATE, VOLUME = (
    "program",
    "systems",
    "knos",
    "voice",
    "rate",
    "volume",
)


VOICE_MODEL_LIST = [
    {
        "Name": "en-US-BrianMultilingualNeural",
        "Gender": "男",
        "VoicePersonalities": "Approachable, Casual, Sincere",
        "ContentCategories": "Conversation, Copilot",
    },
    {
        "Name": "zh-CN-YunyangNeural",
        "Gender": "男",
        "VoicePersonalities": "Professional, Reliable",
        "ContentCategories": "News",
    },
    {
        "Name": "zh-CN-XiaoxiaoNeural",
        "Gender": "女",
        "VoicePersonalities": "News, Novel",
        "ContentCategories": "Warm",
    },
    {
        "Name": "zh-CN-YunjianNeural",
        "Gender": "男",
        "VoicePersonalities": "Passion",
        "ContentCategories": "Sports,  Novel",
    },
    {
        "Name": "en-AU-WilliamMultilingualNeural",
        "Gender": "男",
        "VoicePersonalities": "Friendly, Positive",
        "ContentCategories": "General",
    },
    {
        "Name": "zh-CN-XiaoxiaoMultilingualNeural",
        "Gender": "女",
        "VoicePersonalities": "温暖、清晰",
        "ContentCategories": "Conversation, Copilot",
    },
    {
        "Name": "zh-CN-liaoning-XiaobeiNeural",
        "Gender": "女",
        "VoicePersonalities": "Humorous",
        "ContentCategories": "Dialect",
    },
    {
        "Name": "zh-CN-shaanxi-XiaoniNeural",
        "Gender": "女",
        "VoicePersonalities": "Bright",
        "ContentCategories": "Dialect",
    },
    {
        "Name": "zh-CN-YunxiNeural",
        "Gender": "男",
        "VoicePersonalities": "Lively, Sunshine",
        "ContentCategories": "Novel",
    },
    {
        "Name": "zh-CN-XiaoyiNeural",
        "Gender": "女",
        "VoicePersonalities": "Lively",
        "ContentCategories": "Cartoon, Novel",
    },
    {
        "Name": "zh-CN-YunxiaNeural",
        "Gender": "男",
        "VoicePersonalities": "Cute",
        "ContentCategories": "Cartoon, Novel",
    },
    {
        "Name": "zh-CN-XiaoxuanNeural",
        "Gender": "女",
        "VoicePersonalities": "成熟、稳重",
        "ContentCategories": "Narration, Documentary",
    },
    {
        "Name": "en-US-AndrewMultilingualNeural",
        "Gender": "男",
        "VoicePersonalities": "Warm, Confident, Authentic, Honest",
        "ContentCategories": "Conversation, Copilot",
    },
    {
        "Name": "en-US-AvaMultilingualNeural",
        "Gender": "女",
        "VoicePersonalities": "Expressive, Caring, Pleasant, Friendly",
        "ContentCategories": "Conversation, Copilot",
    },
    {
        "Name": "en-US-EmmaMultilingualNeural",
        "Gender": "女",
        "VoicePersonalities": "Cheerful, Clear, Conversational",
        "ContentCategories": "Conversation, Copilot",
    },
]


def config_dir() -> Path:
    return Path(os.path.expanduser("~")) / ".config" / "supermemo_toolkit"


def read_smtk_conf() -> dict:
    """返回smtk config，如果没有就创建空配置文件"""
    curr_conf_dict = {}
    p = config_dir() / "conf.json"
    init_conf_dict = {PROGRAM: "null"}
    if not os.path.exists(config_dir()):
        os.makedirs(config_dir())
        # 创建空配置文件
        dump_config(p, init_conf_dict)
    elif not os.path.exists(p):
        # 创建空配置文件
        dump_config(p, init_conf_dict)
    else:
        curr_conf_dict = read_config(p)
    return curr_conf_dict


def read_config(conf_path: str) -> dict:
    """读取全部配置返回Dict"""
    with open(conf_path, "r", encoding="utf-8") as json_file:
        config = json.load(json_file)
    return config


def dump_config(conf_path: str, config: dict):
    """更新全部配置序列化Dict"""
    with open(conf_path, "w", encoding="utf-8") as json_file:
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
            collections.update(
                {current: os.path.normpath(os.path.join(path, "elements"))}
            )

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
