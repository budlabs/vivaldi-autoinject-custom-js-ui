#!/bin/bash

_source=$(readlink -f "${BASH_SOURCE[0]}")
_optd=/opt/vivaldi/resources/vivaldi
_shared=/usr/share/vivaldi-UI-js

_trg=$_optd/browser.html

# if this is script is executed on a Arch install
# a hook to automatically update vivaldis UI is added
_pmhookpath=/usr/share/libalpm/hooks/vivaldi-UI-js.hook

_pmhookfile=$(cat << EOB
[Trigger]
Type = Path
Operation = Install
Operation = Upgrade
Target = opt/vivaldi/resources/vivaldi/browser.html

[Action]
Description = injecting custom javascript
When = PostTransaction
Exec = ${_source}
EOB
)

main() {

  ((EUID)) && ERX \
    "script needs to be executed as root (sudo)"

  [[ -f $_trg ]] || ERX \
    "could not find $_trg, is vivaldi installed?"

  # make sure all files to add have .js suffix
  for f in "$@" "$_shared"/*.js ; do
    [[ -f $f && $f =~ [.]js$ ]] && files+=("$f")
  done

  ((${#files[@]})) || ERX \
    "could not find any js files to inject." \
    "add files to $_shared"                  \
    "or as arguments to this command"

  mkdir -p "$_shared"
  readonly _tmp=$(mktemp)
  trap 'rm -f "$_tmp"' EXIT SIGINT

  cp -f "$_trg" "$_tmp"

  for f in "${files[@]}"; do
    str=$(printf '<script src="%s"></script>' "${f##*/}")
    cp -f "$f" "$_optd"

    # files passed as arguments overwrites existing
    # files in /usr/share/vivaldi-UI-js
    [[ $f = "$_shared/${f##*/}" ]] \
      || cp -f "$f" "$_shared"

    # adds entry in browser.html if it doesn't exist
    grep "$str" "$_tmp" >/dev/null \
      || sed -ri "s|([[:space:]]*)(</body>)|\1\1$str\n\1\2|" "$_tmp"
  done

  cp -f "$_tmp" "$_trg"

  # install pacman hook, if it does't exist
  [[ -d ${_pmhookpath%/*} && ! -f $_pmhookpath ]] \
    && echo "$_pmhookfile" > "$_pmhookpath"
}

ERX(){
  { echo -n "[ERROR]: " ; printf '%s\n' "$@" ;} >&2
  exit 1
}

main "$@"
