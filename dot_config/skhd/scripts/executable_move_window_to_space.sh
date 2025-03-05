#!/bin/bash

win=$(yabai -m query --windows --window | jq '.id')

space=$1

yabai -m window --space "$space" && yabai -m window --focus "$win"
