#!/bin/bash
export HOME=/home/deploy/
export RACK_ENV='production'
export PORT=5000
export APPNAME='permit'
export PIDFILE="/data/${APPNAME}/current/tmp/${APPNAME}.pid"
export LOGFILE="/data/${APPNAME}/current/log/${RACK_ENV}.log"
export APPCOMMAND="bundle exec ruby server.rb --port ${PORT} --environment ${RACK_ENV} --pid ${PIDFILE} --log ${LOGFILE} --daemonize"

case $1 in
  start)
    cd /data/${APPNAME}/current
    exec $APPCOMMAND
    ;;
  stop)
    kill `cat $PIDFILE`
    rm $PIDFILE
    ;;
  *)
    echo "usage: goliath_wrapper {start\|stop}" ;;

esac
