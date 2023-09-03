#!/bin/bash

addfiles() {

  declare -a files

  # make sure all files to add have .js suffix
  for f in "$@" "$_shared"/*.js ; do
    [[ -f $f && $f =~ [.]js$ ]] && files+=("$f")
  done

  ((${#files[@]})) || ERX \
    "could not find any js files to inject." \
    "add files to $_shared"                  \
    "or as arguments to this command"

  mkdir -p "$_shared"
  
  for f in "${files[@]}"; do
    printf -v str '<script src="%s"></script>' "${f##*/}"
    cp -f "$f" "$_browser_html"

    # files passed as arguments overwrites existing
    # files in /usr/share/vivaldi-UI-js
    [[ $f = "$_shared/${f##*/}" ]] \
      || cp -f "$f" "$_shared"

    # adds entry in browser.html if it doesn't exist
    grep "$str" "$_tmp" >/dev/null \
      || sed -ri "s|([[:space:]]*)(</body>)|\1\1$str\n\1\2|" "$_tmp"
  done
}
