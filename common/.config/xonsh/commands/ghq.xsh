# ローカルリポジトリへの移動
def _cd_local_repo(args, stdin=None):
    cd @($(ghq root).strip() + '/' + $(ghq list | peco).strip())

# リモートリポジトリへの移動
def _cd_remote_repo(args, stdin=None):
    git see @($(ghq list | peco | cut -d "/" -f 2,3).strip())
