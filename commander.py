import importlib
import os
import sys
from typing import Dict, List

base_separator = '/'
if os.name == 'nt':
    base_separator = '\\'

folder = "env"
cmd_folder = "commander"
base_path = f"{folder}{base_separator}{cmd_folder}"

ignored_terms = [
    '__init__',
    'cpython',
    '__pycache__'
]


def get_functions() -> Dict[str, List[str]]:
    functions = []
    for x in os.walk(base_path):
        if x[0] == base_path:
            pass
        else:
            fn = {
                "prefix": x[0].replace(f'{base_path}{base_separator}', ''),
                "suffix": []
            }
            for y in x[2]:
                ignore = False
                for term in ignored_terms:
                    if term in y:
                        ignore = True
                if not ignore:
                    fn['suffix'].append(y.replace(".py", ""))
            functions.append(fn)
    return functions


def find_modules(args: List) -> str:
    functions = get_functions()
    _px, sf = (args[0], args[1])
    for fn in functions:
        for suffix in fn['suffix']:
            if fn['prefix'] == _px and suffix == sf:
                return f"{folder}.{cmd_folder}.{fn['prefix']}.{suffix}"

    print("Module not found please check spelling")


def list_modules() -> None:
    functions = get_functions()
    for fn in functions:
        for suffix in fn['suffix']:
            print(f"{fn['prefix']} {suffix}")


if __name__ == "__main__":

    if "--list" in sys.argv:
        list_modules()
    else:
        try:
            module = importlib.import_module(find_modules(sys.argv[1:]))
        except Exception as e:  # Ignore PyLintBear (W0703)
            print("Module not found please check spelling")
            list_modules()

        if "--help" in sys.argv:
            try:
                module.info()
            except:
                print("No help for this module")
        else:
            module.run(sys.argv[1:])
