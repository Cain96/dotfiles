# -*- coding: utf-8 -*-
import sys
import os.path
# importするための設定
sys.path.append($XONSH_CONFIG_DIR)

# エディタ
$EDITOR = '/usr/local/bin/nvim'
$VISUAL = '/usr/local/bin/nvim'

# Encoding
$LANG="ja_JP.UTF-8"
$LC_ALL="ja_JP.UTF-8"

# vi風の操作がシェル上で直感的でないのでFalse
$VI_MODE = False

# Ctrl + D で終了しない
$IGNOREEOF = True

# tabではなく空白4つ
$INDENT = "    "

# 補完時に大小区別しない
$CASE_SENSITIVE_COMPLETIONS = False

# 連続重複コマンドを保存しない
$HISTCONTROL = "ignoredups"

# 括弧を補完
$XONSH_AUTOPAIR = True

# ディレクトリ名を入力でcd
$AUTO_CD = True

# エラー全て吐くように
$XONSH_SHOW_TRACEBACK = True
$XONSH_TRACEBACK_LOGFILE = os.path.join(os.path.dirname(__file__), '.log')

# サブプロセスタイムアウトのメッセージ抑制
$SUPPRESS_BRANCH_TIMEOUT_MESSAGE = True

# キー入力即評価
$UPDATE_COMPLETIONS_ON_KEYPRESS = True

# ユーザ確認する前に補完を表示する上限数
$COMPLETION_QUERY_LIMIT = 100

# Tab補完メニューで表示する行数
$COMPLETIONS_MENU_ROWS = 5

# BASHの補完機能をそのまま利用する
$BASH_COMPLETIONS.append('/usr/local/etc/bash_completion.d/')

# プロンプトの表記
$PROMPT = "{GREEN}{env_name: {}}{INTENSE_YELLOW} [ {cwd} ] {GREEN}$ "
# 右にgit情報
$RIGHT_PROMPT = "{gitstatus}"
# 下部にuser, host情報を追加
$BOTTOM_TOOLBAR = "{BACKGROUND_WHITE}{BLACK}{user}@{hostname}"

# lsコマンドの結果の見た目
$LSCOLORS = "gxfxcxdxbxegedabagacad"
# cdしたらls
@events.on_chdir
def ls_after_cd(olddir, newdir, **kw):
    ls @(newdir)

# alias
aliases["ls"] = "ls -G"
aliases["l"] = "ls -l"
aliases["lf"] = "ls -f"
aliases["ld"] = "ls -d"
aliases["la"] = "ls -la"
aliases["ll"] = "ls -l"
aliases["so"] = "source"
aliases["sorc"] = "so ~/.config/xonsh/rc.xsh"
aliases["q"] = "quit"
aliases["mkdir"] = "mkdir -p"
aliases["cp"] = "cp -v"
aliases["mv"] = "mv -v"
aliases["rm"] = "rm -v"
aliases["up"] = "cd .."
aliases["f"] = "open ."

## vim / neovim
aliases["vim"] = "nvim"
aliases["v"] = "vim"
aliases["vi"] = "vim"
aliases["vx"] = "vim ~/.config/xonsh/rc.xsh"
aliases["vrc"] = "vim ~/.config/nvim/init.vim"
aliases["vs"] = "vim ~/.ssh/config"

from commands.cd import _cdf, _jj, _find_cd
aliases["cdf"] = _cdf
aliases["jj"] = _jj
aliases["fc"] = _find_cd

from commands.cleanup import _cleanup
aliases["cleanup"] = _cleanup

## git
from commands.git import _git
aliases["git"] = _git
aliases["gc"] = "git checkout"
aliases["gs"] = "git status"
aliases["gp"] = "git push"
aliases["gl"] = "git log"
from commands.gpush import _gpush
aliases["gpush"] = _gpush

## ghq
from commands.ghq import _cd_local_repo, _cd_remote_repo
aliases["g"] = _cd_local_repo
aliases["gh"] = _cd_remote_repo

## pip
from commands.pip import _update, _upgrade
aliases["pip_update"] = _update
aliases["pip_upgrade"] = _upgrade

## docker + peco
from commands.deco import _deco
aliases["deco"] = _deco
from commands.docker_cleanup import _docker_cleanup
aliases["docker-cleanup"] = _docker_cleanup

## Django
aliases["runserver"] = "python manage.py runserver"
## webpack
aliases["webpack"] = "./node_modules/.bin/webpack --config webpack.config.js"
## circleci
aliases["circlevalid"] = "circleci config validate -c .circleci/config.yml"
aliases["circlebuild"] = "circleci build circleci build .circleci/config.yml"
## latexdiff
aliases["difftex"] = "latexdiff-vc --git -e utf8 --flatten -s COLOR -t CFONT -r master"

# 直近のxonshjobをkill
from commands.kill_last import _kill_last
aliases['kill_last'] = _kill_last

# 履歴をpecoへ
from lib.history import get_history
get_history()

# キーバインド
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import (Condition, IsMultiline, HasSelection, EmacsInsertMode, ViInsertMode)
@events.on_ptk_create
def custom_keybindings(bindings, **kw):
    # コマンド入力中にctrl+vでvim編集
    @bindings.add('c-v')
    def edit_in_editor(event):
        event.current_buffer.tempfile_suffix = '.py'
        event.current_buffer.open_in_editor(v)

    # ctrl+rで履歴をpecoに流して検索
    @bindings.add('c-r')
    def select_history(event):
        sess_history = $(history).split('\n')
        hist = get_history(sess_history)
        selected = $(echo @(hist) | peco)
        event.current_buffer.insert_text(selected.strip())

# xontrib
## Docker周りの補完
xontrib load docker_tabcomplete

## vox
xontrib load vox

from lib.vox import _vox_version
@events.on_chdir
def read_vox_version(olddir, newdir, **kw):
    _vox_version(newdir)

from commands.vox import _vox
aliases["vo"] = _vox


## tracebackを省略し見やすくする
xontrib load readable-traceback
$READABLE_TRACE_STRIP_PATH_ENV=True
$READABLE_TRACE_REVERSE=True

import xonsh.tools
import backtrace

# backtraceパッケージの_flush()をOverride
# 元コード : https://github.com/nir0s/backtrace/blob/f2c8683ec53e4fa48ea8c99c196b201bf22fda3e/backtrace.py#L36
def __flush(message):
    st = message + '\n'
    sys.stderr.buffer.write(st.encode(encoding="utf-8"))
backtrace._flush=__flush

# xonshのprint_exception()をOverride
# 元コード : https://github.com/xonsh/xonsh/blob/230f77b2bc64cbc3e04837377252793f5d09b9ba/xonsh/tools.py#L798
def _print_exception(msg=None):
    tpe, v, tb = sys.exc_info()
    backtrace.hook(tb=tb, tpe=tpe, value=v)
    if msg:
        msg = msg if msg.endswith('\n') else msg + '\n'
        sys.stderr.write(msg)
xonsh.tools.print_exception = _print_exception

# ライブラリの実行時import
# https://vaaaaaanquish.hatenablog.com/entry/2017/12/26/190153
# xonsh上で使うときがありそうなライブラリはlazyasdで補完時、実行時に読み込み
from xonsh.lazyasd import lazyobject
import importlib
lazy_module_dict = {
    'random': 'random',
    'requests': 'requests',
}
for k,v in lazy_module_dict.items():
    t = "@lazyobject\ndef {}():\n    return importlib.import_module('{}')".format(k, v)
    exec(t)

$DJANGO_READ_ENV_FILE = True
