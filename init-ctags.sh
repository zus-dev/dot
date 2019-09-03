#!/bin/bash
# Compatibility
# These patterns are only usable with Exuberant Ctags.
# Universal Ctags is not currently supported and there's no plan to support it in the foreseeable future.
mkdir -p vendor
cd vendor
git clone https://github.com/romainl/ctags-patterns-for-javascript.git
cd ..
echo "--options=$PWD/vendor/ctags-patterns-for-javascript/ctagsrc" >> ~/.ctags
