#!/bin/bash

is_fullscreen=$(yabai -m query --windows --window | jq '."has-fullscreen-zoom"')

echo "preview $is_fullscreen"

if [ "$is_fullscreen" = true ] ; then
   echo "before exec ======"
   yabai -m window --toggle zoom-fullscreen
fi 

yabai -m window --focus recent

is_fullscreen=$(yabai -m query --windows --window | jq '."has-fullscreen-zoom"')

echo "after $is_fullscreen"

if [ "$is_fullscreen" = false ] ; then
   echo "after exec ======"
   yabai -m window --toggle zoom-fullscreen
fi

