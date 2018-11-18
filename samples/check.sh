#! /bin/sh -vx

# Copyright 2018 Takuji Tanaka <ttk@t-lab.opal.ne.jp>
# You may freely use, modify and/or distribute this file.

testdir=./test
convbkmk=../convbkmk.rb

rc=0

## for bookmark
. ./check_bkmk.sh

## for dvi specials
. ./check_dvi.sh

exit $rc

