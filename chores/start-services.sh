#!/bin/bash
#vim:ft=bash

services="service-1 service-2"

echo "Starting service-1, service-2"
script="<path-to-jvm-run-module>"

for str in $services; do
  $script $str
done

