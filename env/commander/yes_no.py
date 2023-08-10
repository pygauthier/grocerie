
def yes_no(message: str) -> bool:
    r = input(f"{message}? (Y/N) ")
    while r.lower() not in ['y', 'n']:
        r = input(f"{message} la reponse doit etre 'Y/N' ")
    if r.lower() == 'y':
        return True
    return False
