#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
THIS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
source $THIS_DIR/../settings.sh

echo "This will likely only work if you have sourced in the 'activate' from virtualenv, trying... "
APP_PID=$(ps -ax -o pid,command |grep app.py |grep -v grep | cut -f 2 -d " ")
echo "Killing $APP_PID"
kill $APP_PID > /dev/null 2>&1

cd $THIS_DIR
python app.py