#!/bin/sh
# Author: Faizal Zakaria
# Helpers functions

#
# $1: msg
#
function p_success {
  echo -e "\t\033[1;32m $1 \033[0m"
}

#
# $1: msg
#
function p_failed {
  echo -e "\t\033[1;31m $1 \033[0m"
}

#
# $1: msg
#
function p_info {
  echo -e "\t\033[1;33m $1 \033[0m"
}

#
# Check error from last executed command through $?
#
function check_error {
  error=$?
  if [ "$error" != "0" ]; then
    p_failed "Failed"
  else
    p_success "Success"
  fi
}
