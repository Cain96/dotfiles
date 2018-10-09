def _update(args, stdin=None):
    pip install -U pip

def _upgrade(args, stdin=None):
    pip install -U pip
    updatepkg = $(pip list --outdated | awk '{print $1}')
    print(updatepkg)
    updatepkg = updatepkg.split()[2:]
    if updatepkg:
        for pkg in updatepkg:
            pip install -U @(pkg)
    else:
        print('already pip upgrade')
