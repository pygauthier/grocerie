#!/bin/sh
cd /app || exit 1

USERID=$(stat -c %u /app)
GROUPID=$(stat -c %g /app)

if [ "$USERID" -ne "$(id app -u)" ] && [ "$USERID" -ne 0 ]; then
    sudo usermod --uid $USERID app
fi

if [ "$GROUPID" -ne "$(id app -g)" ]  && [ "$GROUPID" -ne 100 ]  && [ "$GROUPID" -ne 0 ] ; then
    sudo groupmod --gid $GROUPID app
fi

case $1 in
    shell)
        exec ipython
        ;;
    wait)
        # Keep docker up
        exec tail -f /dev/null
        ;;
    *)
        exec "$@"
        ;;
esac
