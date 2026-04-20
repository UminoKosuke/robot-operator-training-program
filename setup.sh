#!/bin/bash

export OPT_NAME="kosuke_umino" # example: "yamada_taro"
export REPO_ID="operator-training/${OPT_NAME}_${TODAY}" # Don't Change!!
export TASK_NAME="Pick up the cube and place it on the tray" # Set task name

TODAY=$(date "+%Y%m%d")
export REPO_ROOT="$HOME/.cache/huggingface/lerobot/$REPO_ID" # Don't Change!!
export FRONT_CAM_ID="8"  # Set front cam id
export LEFT_CAM_ID="0"  # Set left cam id
export RIGHT_CAM_ID="4"  # Set right cam id
export EPISODE_TIME="60"
export REST_TIME="20"
export WARM_UP_TIME="7"
