#!/bin/bash

# if this is script is executed on a Arch install
# a hook to automatically update vivaldis UI is added
installhook() {

local hookpath=$_prefix/share/libalpm/hooks/vivaldi-UI-js.hook

[[ -d ${hookpath%/*} && ! -f $hookpath ]] || return

cat << EOB > "$hookpath"
[Trigger]
Type = Path
Operation = Install
Operation = Upgrade
Target = ${_trg#/}

[Action]
Description = injecting custom javascript
When = PostTransaction
Exec = ${_source}
EOB
}
