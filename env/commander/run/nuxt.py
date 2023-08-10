import os

docker_name = "grocerie_front"
null = "2> /dev/null"
base_separator = '/'
if os.name == 'nt':
    base_separator = '\\'
    null = "> NULL"


def run(passing_args: str) -> None:
    print("├─ [django] Starting API.")
    command = f'docker exec -u 0 -it {docker_name} yarn dev'
    os.system(f"{command}")
    print("└─ [django] Done.")


def info() -> None:
    print(f"├─ [help] Start nuxt")
