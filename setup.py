from setuptools import find_packages, setup

# pip install .

setup(
    name="smtk",
    version="0.0.1",
    author="明玥",
    description="SuperMemo 增强工具集，命令工具",
    url="https://github.com/Zacharia2/SuperMemo-Toolkit",
    license="GPLv2",
    install_requires=[
        "beautifulsoup4==4.12.2",
        "chardet==5.2.0",
        "docopt==0.6.2",
        "EbookLib==0.18",
        "Pillow==10.1.0",
        "pypinyin==0.49.0",
        "Requests==2.31.0",
        "tqdm==4.65.0",
        "python-magic==0.4.27",
        "python-magic-bin==0.4.14",
        "shutils==0.1.0",
        "psutil",
        "numpy>=1.19.5",
        "matplotlib",
    ],
    # py_modules=[],
    packages=find_packages(),
)
