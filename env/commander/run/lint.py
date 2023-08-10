import os

docker_name = "grocerie_front"

_dir = "$(pwd)"
if os.name == 'nt':
    _dir = '%cd%'


def run(passing_args: str) -> None:
    print("├─ [coding] Starting Lint.")
    os.system(f"docker exec -u 0 -it {docker_name} yarn lint")
    print("└─ [coding] Done.")


def info() -> None:
    print(f"├─ [help] linint")
