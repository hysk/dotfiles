#! /bin/bash

echo "start"

cd `dirname $0`

echo "git submodule update"
git submodule update --init

targets=(.vimrc .vim .git-completion.bash .git-prompt.sh)

for file in ${targets[@]}; do
    fpath=$HOME/$file
    echo "$fpath"
    if [ -a $fpath ]; then
        echo "->already exists."
    else
        ln -s $PWD/$file $fpath
        echo "->link created."
    fi
done



