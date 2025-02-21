#!/bin/bash
## vim:ft=bash

# get env vars
jdk=$JAVA_HOME
root=$REPO

# get args
module=$1
path=${2:-''}  # must include trailing / in the path if specified

# package module if needed
cd $root
if ! [[ -f "$root/$path$module/target/$module-1.0-SNAPSHOT.jar" ]]; then
  echo "packaging $module..."
  mvn package -T 5 -pl :$module -am
  echo "finished packaging $module"
fi

props=''
if [[ -f "$root/$path$module/configuration.properties" ]]; then
  props="$root/configuration.properties:$path$module/configuration.properties"
elif [[ -f "$root/$path$module/configuration.properties.edn" ]]; then
  props="$path$module/configuration.properties.edn"
fi

echo "starting $module"
cmd="$jdk/bin/java -ea -Dlogback.configurationFile=file://$root/logback-dev.xml -Dic.configurationFile=$props -jar $root/$path$module/target/$module-1.0-SNAPSHOT.jar"

log_dir="$LOGS_DIR/$module.log"
nohup $cmd > $log_dir 2>&1 &
