#! /bin/sh -vx

# Copyright 2018 Takuji Tanaka <ttk@t-lab.opal.ne.jp>
# You may freely use, modify and/or distribute this file.

testdir=./test

rc=0

# with dvips
nkf -e $testdir/bkmk-p-dpps.ps > bkmk-p-dpps-euc.ps && convbkmk -e bkmk-p-dpps-euc.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=1

nkf -s $testdir/bkmk-p-dpps.ps > bkmk-p-dpps-sjis.ps && convbkmk -s bkmk-p-dpps-sjis.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=2

cp $testdir/bkmk-up-dpps.ps bkmk-up-dpps.ps && convbkmk -u bkmk-up-dpps.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=3

nkf -e $testdir/bkmk-p-dpps.ps > bkmk-p-dpps-euc.ps && convbkmk -g bkmk-p-dpps-euc.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=4

nkf -s $testdir/bkmk-p-dpps.ps > bkmk-p-dpps-sjis.ps && convbkmk -g bkmk-p-dpps-sjis.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=5

cp $testdir/bkmk-up-dpps.ps bkmk-up-dpps.ps && convbkmk -g bkmk-up-dpps.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=6

cp $testdir/bkmk-up-dpps.ps bkmk-up-dpps-ov.ps && convbkmk -O bkmk-up-dpps-ov.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-ov.ps || rc=7


# with dvipdfmx

cp $testdir/bkmk-p-dpdx_bak.out bkmk-p-dpdx.out && convbkmk -o bkmk-p-dpdx.out && diff -q $testdir/bkmk-p-dpdx.out bkmk-p-dpdx.out || rc=101

cp $testdir/bkmk-up-dpdx_bak.out bkmk-up-dpdx.out && convbkmk -o bkmk-up-dpdx.out && diff -q $testdir/bkmk-up-dpdx.out bkmk-up-dpdx.out || rc=101

cp $testdir/bkmk-docinfo_bak.out bkmk-docinfo.out && convbkmk -o bkmk-docinfo.out && diff -q $testdir/bkmk-docinfo.out bkmk-docinfo.out || rc=103


exit $rc


