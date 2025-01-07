#!/bin/bash
#vim:ft=bash

services="service-1 service-2"

echo "Sending SIGINT service-1, service-2"
for str in $services; do
  tmux list-panes -F "#{pane_pid}" -t $str | xargs ps -o tpgid= | xargs -I{} kill -s SIGINT -{}
done

sleep 10

echo "Closing service-1, service-2"
for str in $services; do
  tmux kill-window -t $str
done

echo "Finished"

