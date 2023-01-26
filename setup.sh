#!/bin/sh

  echo "this script will copy the custom_command file as hidden in your"
  echo "home folder, it will then create 2 aliases in your .zshrc or .bashrc :"
  echo "format - destined to format your code"
  echo "open - to open the current codebase in XCode"
  echo ""
  echo "This script is currently configured for the Noisy project but is destined to be cross-repo"

  read -p "do you want to proceed ? (y/n)" answer

if [ "$answer" == "y" ]; then

  # gets the path to the aliases and custom command file
  aliases=$(cat $PWD/aliases.txt)
  custom_commands="$PWD/custom_commands.txt"

  # check weather to write to zshrc or bashrc
  if [ "$SHELL" == "/bin/zsh" ]; then
    rc_file="$HOME/.zshrc"
  else
    rc_file="$HOME/.bashrc"
  fi

  #finds the path to the custom_command script
  custom_command_path="$HOME/.custom_commands.sh"

  cp $custom_commands $custom_command_path

  # check weather there is already aliases in the rc_file
  is_there_already_a_script=$(grep "expressiveeScript" ~/.zshrc)
  if [ -n "$is_there_already_a_script" ]; then
    echo "Seems like there is already an expressivee alias in $rc_file"
    echo "If you would like to proceed, make sure to delete the old set of aliases."

    read -p "do you want to proceed ? (y/n)" answer

    if [ "$answer" != "y" ]; then
    exit
    fi
  fi
  echo "\n$aliases" >> $rc_file

  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo -e "\n${RED}To make changes effective make sure to run the 'source ~/.zshrc' command or restart your terminal window${NC}"


else
  echo "aborting now"
  exit
fi
