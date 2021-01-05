#!/usr/bin/env bash
echo $BASH_VERSION
echo "$(tput sgr0)"

# DATA
source ./functions/assistant_story.sh

# CODE
welcome_story

home_menu_story