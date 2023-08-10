import os

null = "2> /dev/null"
base_separator = '/'
if os.name == 'nt':
    base_separator = '\\'
    null = "> NULL"

folder = f"{base_separator}env{base_separator}"
image_name = "grocerie/nuxt"
docker_name = "grocerie/nuxt"


def run(passing_args: str) -> None:
    print(f"├─ [docker] Building docker image {image_name}.")
    os.system(f"docker build --no-cache -t {image_name} . -f .{folder}Dockerfile")
    print("└─ [docker] Done.")


def info() -> None:
    print(f"└─ [help] Build docker image {image_name}")
