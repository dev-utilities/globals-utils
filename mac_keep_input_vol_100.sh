#!/bin/bash
last_vol=-1
counter=0
last_change_time=$(date +%s)  # record start time

while true; do
  ((counter++))
  echo "Run #$counter"

  vol=$(osascript -e "input volume of (get volume settings)")
  if [ "$vol" -ne "$last_vol" ]; then
    if [ "$last_vol" -ne -1 ]; then
      echo "$(date): input volume changed from $last_vol to $vol" 
    else
      echo "$(date): initial input volume detected: $vol" 
    fi

    if [ "$vol" -lt 100 ]; then
      osascript -e "set volume input volume 100"
      echo "$(date): input volume adjusted from $vol to 100" 
      last_vol=100
    else
      last_vol=$vol
    fi

    last_change_time=$(date +%s)  # reset timer
    sleep 1
  else
    current_time=$(date +%s)
    idle_time=$(( current_time - last_change_time ))
    if [ "$idle_time" -ge 1800 ]; then
      echo "$(date): No volume change for 5 minutes. Exiting." 
      break
    fi
    sleep 5
  fi
done
