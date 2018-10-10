# upstreamをfetch,rebase
def _pullstream(args, stdin=None):
    remote_name = 'upstream'
    if args > 0:
        remote_name = args[0]

    print('git fetch {}'.format(remote_name))
    git fetch @(remote_name)

    print('git rebase {}/master'.format(remote_name))
    git fetch @(remote_name)/master
