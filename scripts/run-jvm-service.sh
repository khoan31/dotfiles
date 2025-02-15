#!/bin/bash
#vim:ft=bash

# get env vars
jdk=$JAVA_HOME
root=$IC_REPO/java

# get args
module=$1
path=${2:-""}  # must include trailing / in the path if specified

echo "Preparing $module ..."
cd $root
if ! [[ -f "$root/$path$module/target/$module-1.0-SNAPSHOT.jar" ]]; then
  echo "Packaging $module ..."
  mvn package -pl :$module -am
  echo "Finished packaging $module"
fi

props=""
if [[ -f "$root/$path$module/configuration.properties" ]]; then
  props="$root/configuration.properties:$path$module/configuration.properties"
elif [[ -f "$root/$path$module/configuration.properties.edn" ]]; then
  props="$path$module/configuration.properties.edn"
fi

echo "Starting $module ..."
cmd="$jdk/bin/java -ea -Dlogback.configurationFile=file://$root/logback-dev.xml -Dic.configurationFile=$props -jar $root/$path$module/target/$module-1.0-SNAPSHOT.jar"

log_dir="$IC_LOG_DIR/$module.log"
nohup $cmd > $log_dir 2>&1 &
