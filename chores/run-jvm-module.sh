#!/bin/bash
#vim:ft=bash

# Set current active JDK
jdk=$JAVA_HOME

# * REMEMBER to set this environment variable
root=$REPOS

# Get args
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

tmux new-window -n "$module" "$cmd"

