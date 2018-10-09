def _git(args, stdin=None):
    if len(args) > 0 and args[0] == "see":
        args[0] = "browse"
    args = ['hub'] + args
    @(args)
