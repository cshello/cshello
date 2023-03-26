#!/usr/env/env python
# -*- coding=utf-8 -*-

import os 
import glob 
import argparse


def gen_title(path, sup_suffix=(".txt", ".md", ".ipynb")):
    """
    搜索路径path下，所有的sup_suffix文件，并生成一个超链接树。
    例如：
        path $ tree
        Basics:
            - a.txt
            - b
                - b.md
            - c
                - c.ipynb
    将生成  
    ```
- [Basics](Basics)
  - [a.txt](Basics/a.txt]
  - [b](Basics/b)
    - [b.md](Basics/b/b.md)
    - [c.ipynb](Basics/c/c.ipynd)

    ```
    """
    
    path = os.path.abspath(path)
    paths = glob.glob(os.path.join(path, "**"), recursive=True)
    
    paths = sorted(paths)

    s_remove = os.path.dirname(path)
    res = list()
    for i, p in enumerate(paths):
        p = p.removeprefix(s_remove).removeprefix(os.sep).removesuffix(os.sep)
        lis = p.split(os.sep)
        
        name_ = f"{lis[-1]}"
        url_ = os.sep.join(lis)
        s_white = "  " * (len(lis) - 1 )
        res.append(f"{s_white} - [{name_}]({url_})")
    # print(*res, sep="\n")
    return res 



if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generate hyperlinks to the file tree."
            )
    parser.add_argument(
        "-path", type=str, default="Basics"
            )

    args = parser.parse_args()
    path =  args.path
    # print(args, path)
    res = gen_title(path)
    print(*res, sep="\n")
   

