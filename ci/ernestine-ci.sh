#!/bin/bash
#
# Climc continuous integration tool
#

set -e
set -x
export PROJECT=ernestine
export TEST_ENV=$PWD/.clenv

cleanup() {
    rm -fr $TEST_ENV
    mkdir $TEST_ENV
}

init() {
    cp ci/init.lisp $TEST_ENV
    cd $TEST_ENV
    wget -q http://beta.quicklisp.org/quicklisp.lisp -O quicklisp.lisp
    sbcl --script init.lisp
    ln -s $PWD/.. ./.quicklisp/local-projects/$PROJECT
    cd ..
}

ci() {
    sbcl --script ci/$PROJECT-ci.lisp
}

cleanup
init
ci
