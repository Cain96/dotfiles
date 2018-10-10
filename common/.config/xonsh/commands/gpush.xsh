def _gpush(args, stdin=None):
    current_branch = $(git rev-parse --abbrev-ref HEAD).strip()
    if current_branch:
        print("git push origin {}".format(current_branch))

        if current_branch == 'master':
            print('Your branch is master. push origin master? (Y/n):', end='')
            yn = input()
            if yn == "Y":
                git push origin @(current_branch)
        else:
            git push origin @(current_branch)
