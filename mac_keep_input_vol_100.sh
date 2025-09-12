#!/bin/bash
last_vol=-1
counter=0

while true; do
  ((counter++))
  echo "Run #$counter"

  vol=$(osascript -e "input volume of (get volume settings)")
  if [ "$vol" -ne "$last_vol" ]; then
    echo "$(date): volume changed to $vol" >> ~/input_vol_out.txt
    if [ "$vol" -lt 100 ]; then
      osascript -e "set volume input volume 100"
    fi
    last_vol=$vol
    sleep 1
  else
    sleep 5
  fi
done
