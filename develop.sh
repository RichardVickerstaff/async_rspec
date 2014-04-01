#put this file in your bashrc

function cat_fifo(){
  fifo="$1"
  if [ -p $fifo ]; then
      rm $fifo
    fi

    mkfifo $fifo

    while true; do sh -c "$(cat $fifo)"; done
}
