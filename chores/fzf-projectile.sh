#!/bin/bash
#vim:ft=bash

# Fuzzy find the project directory
dir=$(fd -t d -d 3 . $REPOS | fzf)

# If the directory is empty, exit
if [ -z "${dir}" ]; then
  exit 0
fi

# Open the selected repo
cd $dir; nvim .
