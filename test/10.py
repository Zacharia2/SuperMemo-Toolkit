import logging


def setup_logger():
    """设置日志记录器，添加文件处理器和格式化器"""
    # 创建记录器并设置等级
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)

    # 创建文件处理器并设置等级
    file_handler = logging.FileHandler("log.txt")
    file_handler.setLevel(logging.INFO)

    # 创建格式化器并设置到处理器
    formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    )
    file_handler.setFormatter(formatter)

    # 添加处理器到记录器
    logger.addHandler(file_handler)

    return logger


# 设置记录器
logger = setup_logger()

# 记录信息
logger.info("Start print log")
logger.debug("Do something")  # 这条信息不会被记录，因为等级太低
logger.warning("Something maybe fail.")
logger.info("Finish")
