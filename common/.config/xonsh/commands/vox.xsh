# voxの拡張
# pyenvのlocal機能を追加
import os

def _vox(args, stdin=None):
    if len(args) == 1 and args[0] == "local":
        if(os.path.isfile("./.python-version")):
            print("vox version : {}".format($(cat .python-version).strip()))
        else:
            print(".python-version does not exist")
    elif len(args) == 2 and args[0] == "local":
        if(args[1] == "--unset"):
            rm -f .python-version
        elif(not os.path.isfile("./.python-version")):
            echo @(args[1]) > .python-version
            vox activate @(args[1])
        else:
            print("already .python-version exists!")
    else:
        @(['vox'] + args)
