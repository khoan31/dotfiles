#!/bin/bash
#vim:ft=bash

services=$IC_SERVICES
script=$SCRIPTS/run-jvm-service.sh
log_dir=$IC_LOG_DIR

function start() {
  rm -f $log_dir/*
  # Start pre-requisite services
  echo "Starting pre-requisite services..."
  nohup sh -c "$IC_CONSOLE" > $log_dir/console.log 2>&1 &
  nohup sh -c "$IC_RIEMANN" > $log_dir/riemann.log 2>&1 &
  sleep 5

  # Start JVM services
  for str in $services; do
    if [[ $str == *":"* ]]; then
      IFS=':' read -r -a array <<< "$str"
      if [ -z "${array[1]}" ]; then
        $script ${array[0]}
      else
        $script ${array[0]} ${array[1]}
      fi
    else
      $script $str
    fi
  done
}

function stop() {
  # Kill all JVM processes
  jps -v | grep 1.0-SNAPSHOT.jar | awk "{print $1}" | xargs kill
  jps -v | grep display.name=riemann | awk "{print $1}" | xargs kill

  # Kill the remaining processes
  ps -v | grep "ng serve" | awk "{print $1}" | xargs kill
}

"$@"
