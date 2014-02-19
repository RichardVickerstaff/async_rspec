#!/bin/bash

project_root=$1
tmux_session=$(basename $project_root)

pushd $project_root >/dev/null

if [ -p commands ]; then
  rm commands
fi

mkfifo commands

export TERM=xterm-256color

tmux has-session -t $tmux_session
if [ $? != 0 ]; then
  window=1
  tmux new-session -s $tmux_session -n tests -d
  tmux send-keys -t ${tmux_session}:$window "while true; do sh -c '$(cat commands)'; done" C-m

  window=2
  tmux new-window -t ${tmux_session} -n code
  tmux send-keys -t ${tmux_session}:$window 'vim' C-m

  window=3
  tmux new-window -t $tmux_session -n shell

  tmux select-window -t ${tmux_session}:2
fi
tmux attach -t $tmux_session

popd >/dev/null
