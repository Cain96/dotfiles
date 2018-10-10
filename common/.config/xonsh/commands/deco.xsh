import xonsh
def _deco(args, stdin=None):
    if len(args) > 0:
        if args[0] == "ps":
            command = [
                'docker', 'ps',
                '--format', '{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.RunningFor}}',
            ]
            if len(args) > 2:
                @(command + args[1:]) | peco | awk '{print $1}'
            else:
                @(command) | peco | awk '{print $1}'
        elif args[0] == "exec":
            docker exec -it @($(deco ps).strip()) /bin/bash
        elif args[0] == "start":
            docker start  @($(deco ps -a).strip())
        elif args[0] == "stop":
            docker stop @($(deco ps -a).strip())
        else:
            @(['docker'] + args)
    else:
        docker
