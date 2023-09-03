#!/bin/bash

removefile() {

  local trg=${1##*/}
  local sharef="$_shared/$trg"
  local optf="$_optd/$trg"

  [[ -f $sharef ]] \
    || ERX "file $sharef not found"

  rm -f "$sharef" "$optf"

  str=$(printf '<script src="%s"></script>' "$trg")

  grep -v "$str" "$_browser_html" > "$_tmp"
}
