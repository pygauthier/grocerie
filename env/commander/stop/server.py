import os

null = "2> /dev/null"
base_separator = '/'
if os.name == 'nt':
    base_separator = '\\'
    null = "> NULL"

folder = f"{base_separator}env{base_separator}"


def run(passing_args: str) -> None:
    print("├─ [env] Stopping server.")
    os.system(f"docker compose -f .{folder}docker-compose.yml down {null}")
    print("└─ [env] Done.")


def info() -> None:
    print("└─ [help] Stop project server\n")
