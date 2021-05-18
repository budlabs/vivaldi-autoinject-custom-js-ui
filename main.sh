#!/usr/bin/env bash

# in makefile m4 will expand PREFIX
# before installation
if [[ -d PREFIX ]]; then
  _prefix='PREFIX'
else
  _prefix=/usr
fi

_source=$(readlink -f "${BASH_SOURCE[0]}")

_vivaldi=$(readlink -f "$(which vivaldi-stable)")
: "${_vivaldi:=$(readlink -f "$(which vivaldi-snapshot)")}"

_optd=${_vivaldi%/*}/resources/vivaldi
_shared=$_prefix/share/vivaldi-UI-js

_trg=$_optd/browser.html

main() {

  ((__o[list])) && {
    ls -A "$_shared"
    exit
  }

  ((EUID)) && ERX \
    "script needs to be executed as root (sudo)"

  [[ -f $_trg ]] || ERX \
    "could not find $_trg, is vivaldi installed?"

  readonly _tmp=$(mktemp)
  trap 'rm -f "$_tmp"' EXIT SIGINT

  cp -f "$_trg" "$_tmp"

  if [[ -n ${__o[remove]} ]]; then
    removefile "${__o[remove]}"
  else
    addfiles "$@"
  fi

  cp -f "$_tmp" "$_trg"

  installhook
  exit 0
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "${@}"                                     #bashbud
