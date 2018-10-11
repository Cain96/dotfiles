import os
from xonsh.prompt.env import env_name

def parentpath(path=__file__, f=0):
    return str('/'.join(os.path.abspath(path).split('/')[0:-1-f]))

def _vox_version(path):
    f = 0
    if path.startswith($HOME):
        if $(find @(path) -maxdepth 1 -type f -a -name ".python-version"):
            version = $(cat .python-version).strip()
            vox activate @(version)
        elif path != $HOME:
            while(parentpath(path, f) != $HOME):
                if $(find @(parentpath(path, f)) -maxdepth 1 -type f -a -name ".python-version"):
                    version = $(cat .python-version).strip()
                    vox activate @(version)
                    break
                f += 1
            else:
                if env_name():
                    vox deactivate
        elif env_name():
                vox deactivate
    elif env_name():
        vox deactivate
