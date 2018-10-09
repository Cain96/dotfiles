# 指定パス以下の空ディレクトリを削除
import os
def _cleanup(args, stdin=None):
    target_list = $(find . -type d -maxdepth 2 -empty).split()
    for target in target_list:
        rmdir @(target)
