# https://qiita.com/riktor/items/2f18db475dc5b2c8d829
def _git(args, stdin=None):
    if len(args) > 0 and args[0] == "see":
        args[0] = "browse"
    args = ['hub'] + args
    @(args)
