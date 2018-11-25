# Copyright 2018 Takuji Tanaka <ttk@t-lab.opal.ne.jp>
# You may freely use, modify and/or distribute this file.

## for bookmark

# with dvips

nkf -e $testdir/bkmk-p-dpps.ps > bkmk-p-dpps-euc.ps
nkf -s $testdir/bkmk-p-dpps.ps > bkmk-p-dpps-sjis.ps
cp $testdir/bkmk-up-dpps.ps bkmk-up-dpps.ps
cp $testdir/bkmk-up-dpps.ps bkmk-up-dpps-ov.ps

$convbkmk -e bkmk-p-dpps-euc.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=1
$convbkmk -s bkmk-p-dpps-sjis.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=2
$convbkmk -u bkmk-up-dpps.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=3

$convbkmk -g bkmk-p-dpps-euc.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=4
$convbkmk -g bkmk-p-dpps-sjis.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=5
$convbkmk -g bkmk-up-dpps.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=6

$convbkmk --enc=e bkmk-p-dpps-euc.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=7
$convbkmk --enc=s bkmk-p-dpps-sjis.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=8
$convbkmk --enc=u bkmk-up-dpps.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=9

$convbkmk -e < bkmk-p-dpps-euc.ps > bkmk-p-dpps-euc-convbkmk.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=10
$convbkmk -s < bkmk-p-dpps-sjis.ps > bkmk-p-dpps-sjis-convbkmk.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=11
$convbkmk -u < bkmk-up-dpps.ps > bkmk-up-dpps-convbkmk.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=12

$convbkmk -O bkmk-up-dpps-ov.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-ov.ps || rc=13


# with dvipdfmx

nkf -e $testdir/bkmk-p-dpdx_bak.out > bkmk-p-dpdx-euc.out
nkf -s $testdir/bkmk-p-dpdx_bak.out > bkmk-p-dpdx-sjis.out
cp $testdir/bkmk-p-dpdx_bak.out bkmk-p-dpdx.out
cp $testdir/bkmk-up-dpdx_bak.out bkmk-up-dpdx.out
cp $testdir/bkmk-docinfo_bak.out bkmk-docinfo.out

$convbkmk -e -o bkmk-p-dpdx-euc.out && diff -q $testdir/bkmk-p-dpdx.out bkmk-p-dpdx-euc.out || rc=101
$convbkmk -s -o bkmk-p-dpdx-sjis.out && diff -q $testdir/bkmk-p-dpdx.out bkmk-p-dpdx-sjis.out || rc=102
$convbkmk -eo bkmk-p-dpdx-euc.out && diff -q $testdir/bkmk-p-dpdx.out bkmk-p-dpdx-euc.out || rc=103
$convbkmk -so bkmk-p-dpdx-sjis.out && diff -q $testdir/bkmk-p-dpdx.out bkmk-p-dpdx-sjis.out || rc=104
$convbkmk --enc=e -o bkmk-p-dpdx-euc.out && diff -q $testdir/bkmk-p-dpdx.out bkmk-p-dpdx-euc.out || rc=105
$convbkmk --enc=s -o bkmk-p-dpdx-sjis.out && diff -q $testdir/bkmk-p-dpdx.out bkmk-p-dpdx-sjis.out || rc=106
$convbkmk -o bkmk-p-dpdx.out && diff -q $testdir/bkmk-p-dpdx.out bkmk-p-dpdx.out || rc=107
$convbkmk -o bkmk-up-dpdx.out && diff -q $testdir/bkmk-up-dpdx.out bkmk-up-dpdx.out || rc=108
$convbkmk -o bkmk-docinfo.out && diff -q $testdir/bkmk-docinfo.out bkmk-docinfo.out || rc=109

