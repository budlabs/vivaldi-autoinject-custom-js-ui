#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
vivaldi-autoinject-custom-js - version: 2020.11.21.7
updated: 2020-11-21 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
vivaldi-autoinject-custom-js - auto inject custom javascript for vivaldi UI


SYNOPSIS
--------
vivaldi-autoinject-custom-js [--remove|-r FILENAME] [FILES ...]
vivaldi-autoinject-custom-js --list|-l
vivaldi-autoinject-custom-js --help|-h
vivaldi-autoinject-custom-js --version|-v

OPTIONS
-------

--remove|-r FILENAME  

--list|-l  

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
  getopt --name "[ERROR]:vivaldi-autoinject-custom-js" \
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





