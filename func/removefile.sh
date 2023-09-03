#!/bin/bash

removefile() {

  local trg=${1##*/}
  local sharef="$_data_directory/$trg"
  local optf="$_vivaldi_directory/$trg"
  local str

  [[ -f $sharef ]] || ERX "file $sharef not found"

  rm -f "$sharef" "$optf"

  printf -v str '<script src="%s"></script>' "$trg"

  grep -v "$str" "$_browser_html" > "$_tmp"
}
