#!/usr/bin/env bash

# 如果当前window不处于stack状态则优先和上下的窗口进行合并，否则和左右的窗口进行合并
# 如果当前window处于stack状态，则执行两次float，使其脱离stack（因为没有直接exit stack的方法）

is_stack=$(yabai -m query --windows --window | jq '."stack-index"')

if [ "$is_stack" -eq 0 ]; then
  id=$(yabai -m query --windows --window | jq -r '.id')
  yabai -m window south --stack "$id" ||
    yabai -m window north --stack "$id" ||
    yabai -m window east --stack "$id" ||
    yabai -m window west --stack "$id"
else
  yabai -m window --toggle float && yabai -m window --toggle float
fi
