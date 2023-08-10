import os

docker_name = "grocerie_front"


def run(passing_args: str) -> None:
    docker = docker_name
    if len(passing_args) >= 3:
        docker = passing_args[2]
    args = ' '.join(passing_args[3:]) or 'bash'
    print(f"├─ [env] Execute {args}.")
    os.system(f'docker exec -u 0 -it {docker} {args}')
    print("└─ [env] Done.")


def info() -> None:
    print(f"├─ [help] Execute docker commande")
    print("├─ [help] two arguments possible: docker_image_name command")
    print(f"├─ [help] by default arguments are: {docker_name} bash")
    print("└─ [help] exemple: python commander.py docker exec kibana bash")
