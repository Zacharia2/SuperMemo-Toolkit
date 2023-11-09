import configparser
import json

config = configparser.ConfigParser()
# config.read('config.ini')

# value = config.get('section', 'option')


def read_config():
    """ "读取配置"""
    with open("docs/config.json") as json_file:
        config = json.load(json_file)
    return config


def update_config(config):
    """ "更新配置"""
    with open("docs/config.json", "w") as json_file:
        json.dump(config, json_file, indent=4)
    return None


# print(read_config())
# update_config({"program": "test"})
