# 履歴をpecoに流す
# https://qiita.com/riktor/items/4a90b4e125cd091a9d07
# pecoのinstall : https://qiita.com/ngyuki/items/94a7e638655d9910971b
import json
import os
from collections import OrderedDict
from operator import itemgetter

def get_history(session_history=None, return_list=False):
    hist_dir = __xonsh_env__['XONSH_DATA_DIR']
    files = [ os.path.join(hist_dir,f) for f in os.listdir(hist_dir)
              if f.startswith('xonsh-') and f.endswith('.json') ]
    file_hist = [ json.load(open(f))['data']['cmds'] for f in files ]
    cmds = [ ( c['inp'].replace('\n', ''), c['ts'][0] )
                 for cmds in file_hist for c in cmds if c]
    cmds.sort(key=itemgetter(1))
    cmds = [ c[0] for c in cmds[::-1] ]
    if session_history:
        cmds.extend(session_history)
    # dedupe
    zip_with_dummy = list(zip(cmds, [0] * len(cmds)))[::-1]
    cmds = list(OrderedDict(zip_with_dummy).keys())[::-1]
    if return_list:
        return cmds
    else:
        return '\n'.join(cmds)
