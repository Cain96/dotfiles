# Finderのアクティブウィンドウのパスにターミナルで移動
def _cdf(args, stdin=None):
    target = $(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)').strip()
    if target:
        cd @(target)
    else:
        print('No Finder window found')

# カレントパス以下のディレクトリでGrepマッチしたディレクトリに移動
import os
def _jj(args, stdin=None):
    if len(args) > 0:
        target = args[0]
        dir_list = os.listdir(path='.')
        jumpdir = [dir for dir in dir_list if target in dir]
        if jumpdir:
            jumpdir = './' + jumpdir[-1]

        if os.path.exists(jumpdir):
            cd @(jumpdir)
        else:
            print('directory not found')
    else:
        print('Invalid argments')
        print('please enter `jj $(target word)`')

def _find_cd(args, stdin=None):
    cd @($(find . -type d | peco).strip())
