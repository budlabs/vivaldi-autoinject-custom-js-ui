#!/bin/bash

this=$(readlink -f "${BASH_SOURCE[0]}")
dir=${this%/*}
optd=/opt/vivaldi/resources/vivaldi/

brws=$optd/browser.html
brwslocal=$dir/browser.html
