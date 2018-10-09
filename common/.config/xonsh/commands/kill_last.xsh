# https://github.com/zardus/xonshrc/blob/master/xonshrc
def _kill_last(args, stdin=None):
	if __xonsh_active_job__ is None:
		print("No active job. Aborting.")
		return
	cmd = 'kill %s %d' % (''.join(args), __xonsh_all_jobs__[__xonsh_active_job__]['pgrp'])
	os.system(cmd)
