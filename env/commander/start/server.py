import os

from ..yes_no import yes_no  # type: ignore

test = "test"
null = "2> /dev/null"
base_separator = '/'
if os.name == 'nt':
    base_separator = '\\'
    null = "> NULL"

folder = f"{base_separator}env{base_separator}"


def run(passing_args: str) -> None:
    os.system(f"docker stop traefik_reverse_proxy {null}")
    print(f"├─ [env] Start project")
    os.system(f'docker compose -f .{folder}docker-compose.yml up -d')
    print(f"├─ [env] done")

    if yes_no("├─ [django] Start nuxt"):
        print("└─ [django] starting server\n")
        os.system('docker exec -u 0 -it grocerie_front yarn dev')
    else:
        print("└─ [django] skipping.")
        print("Run 'python commander.py run nuxt' to start API")


def info() -> None:
    print("└─ [help] Start project server\n")
