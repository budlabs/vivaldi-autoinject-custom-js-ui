#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
vivaldi-autoinject-custom-js-ui - version: 2020.11.22.9
updated: 2020-11-22 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
vivaldi-autoinject-custom-js-ui - manage custom js UI mods for the vivaldi web browser


SYNOPSIS
--------
vivaldi-autoinject-custom-js-ui [--remove|-r FILENAME] [FILES ...]
vivaldi-autoinject-custom-js-ui --list|-l
vivaldi-autoinject-custom-js-ui --help|-h
vivaldi-autoinject-custom-js-ui --version|-v

OPTIONS
-------

--remove|-r FILENAME  
Remove FILENAME.

--list|-l  
Prints all installed js modifications.


--help|-h  
Show help and exit.


--version|-v  
Show version and exit.

EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
options="$(
  getopt --name "[ERROR]:vivaldi-autoinject-custom-js-ui" \
    --options "r:lhv" \
    --longoptions "remove:,list,help,version," \
    -- "$@" || exit 98
)"

eval set -- "$options"
unset options

while true; do
  case "$1" in
    --remove     | -r ) __o[remove]="${2:-}" ; shift ;;
    --list       | -l ) __o[list]=1 ;; 
    --help       | -h ) ___printhelp && exit ;;
    --version    | -v ) ___printversion && exit ;;
    -- ) shift ; break ;;
    *  ) break ;;
  esac
  shift
done

[[ ${__lastarg:="${!#:-}"} =~ ^--$|${0}$ ]] \
  && __lastarg="" 





