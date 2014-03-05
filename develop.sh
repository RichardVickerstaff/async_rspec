#!/bin/bash

if [ -p commands ]; then
  rm commands
fi

mkfifo commands

while true; do sh -c '$(cat commands)'; done
