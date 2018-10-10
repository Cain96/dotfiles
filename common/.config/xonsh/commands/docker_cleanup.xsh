def _docker_cleanup(args, stdin=None):
    if len(args) > 0:
        target = args[0]
        if target == 'all':
            docker system prune
            docker volume prune
        elif target == 'image':
            docker image prune
        elif target == 'container':
            docker container prune
        elif target == 'network':
            docker network prune
        elif target == 'volume':
            docker volume prune
