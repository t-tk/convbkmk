#! /bin/sh -vx

# Copyright 2018 Takuji Tanaka <ttk@t-lab.opal.ne.jp>
# You may freely use, modify and/or distribute this file.

testdir=./test
convbkmk=../convbkmk.rb

rc=0

nkf -e $testdir/bkmk-p-dpps.ps > bkmk-p-dpps-euc.ps
nkf -s $testdir/bkmk-p-dpps.ps > bkmk-p-dpps-sjis.ps
cp $testdir/bkmk-up-dpps.ps bkmk-up-dpps.ps
cp $testdir/bkmk-up-dpps.ps bkmk-up-dpps-ov.ps

# with dvips

$convbkmk -e bkmk-p-dpps-euc.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=1
$convbkmk -s bkmk-p-dpps-sjis.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=2
$convbkmk -u bkmk-up-dpps.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=3

$convbkmk -g bkmk-p-dpps-euc.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=4
$convbkmk -g bkmk-p-dpps-sjis.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=5
$convbkmk -g bkmk-up-dpps.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=6

$convbkmk --enc=e bkmk-p-dpps-euc.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-euc-convbkmk.ps || rc=7
$convbkmk --enc=s bkmk-p-dpps-sjis.ps && diff -q $testdir/bkmk-p-dpps-convbkmk.ps bkmk-p-dpps-sjis-convbkmk.ps || rc=8
$convbkmk --enc=u bkmk-up-dpps.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-convbkmk.ps || rc=9

$convbkmk -O bkmk-up-dpps-ov.ps && diff -q $testdir/bkmk-up-dpps-convbkmk.ps bkmk-up-dpps-ov.ps || rc=10


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


## for dvi specials

# with dvips

nkf -e $testdir/fig-p-dpps.dvispc > fig-p-dpps-euc.dvispc
nkf -s $testdir/fig-p-dpps.dvispc > fig-p-dpps-sjis.dvispc
cp fig-p-dpps-euc.dvispc fig-p-dpps-euc_bak.dvispc
cp fig-p-dpps-sjis.dvispc fig-p-dpps-sjis_bak.dvispc

$convbkmk -ed fig-p-dpps-euc.dvispc && diff -q $testdir/fig-p-dpps-convbkmk.dvispc fig-p-dpps-euc-convbkmk.dvispc || rc=201
$convbkmk -sd fig-p-dpps-sjis.dvispc && diff -q $testdir/fig-p-dpps-convbkmk.dvispc fig-p-dpps-sjis-convbkmk.dvispc || rc=202

$convbkmk --enc=e -d fig-p-dpps-euc.dvispc && diff -q $testdir/fig-p-dpps-convbkmk.dvispc fig-p-dpps-euc-convbkmk.dvispc || rc=203
$convbkmk --enc=s -d fig-p-dpps-sjis.dvispc && diff -q $testdir/fig-p-dpps-convbkmk.dvispc fig-p-dpps-sjis-convbkmk.dvispc || rc=204

if [ `ptex --version | grep -c 'euc)'`>0 ]; then
  $convbkmk -gd fig-p-dpps-euc.dvispc && diff -q $testdir/fig-p-dpps-convbkmk.dvispc fig-p-dpps-euc-convbkmk.dvispc || rc=205
else
  $convbkmk -gd fig-p-dpps-sjis.dvispc && diff -q $testdir/fig-p-dpps-convbkmk.dvispc fig-p-dpps-sjis-convbkmk.dvispc || rc=206
fi

$convbkmk -edO fig-p-dpps-euc.dvispc && diff -q $testdir/fig-p-dpps-convbkmk.dvispc fig-p-dpps-euc.dvispc || rc=207
$convbkmk -sdO fig-p-dpps-sjis.dvispc && diff -q $testdir/fig-p-dpps-convbkmk.dvispc fig-p-dpps-sjis.dvispc || rc=208

# with dvipdfmx

nkf -e $testdir/fig-p-dpdx.dvispc > fig-p-dpdx-euc.dvispc
nkf -s $testdir/fig-p-dpdx.dvispc > fig-p-dpdx-sjis.dvispc
cp fig-p-dpdx-euc.dvispc fig-p-dpdx-euc_bak.dvispc
cp fig-p-dpdx-sjis.dvispc fig-p-dpdx-sjis_bak.dvispc

$convbkmk -ed fig-p-dpdx-euc.dvispc && diff -q $testdir/fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-euc-convbkmk.dvispc || rc=301
$convbkmk -sd fig-p-dpdx-sjis.dvispc && diff -q $testdir/fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-sjis-convbkmk.dvispc || rc=302

$convbkmk --enc=e -d fig-p-dpdx-euc.dvispc && diff -q $testdir/fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-euc-convbkmk.dvispc || rc=303
$convbkmk --enc=s -d fig-p-dpdx-sjis.dvispc && diff -q $testdir/fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-sjis-convbkmk.dvispc || rc=304

if [ `ptex --version | grep -c 'euc)'`>0 ]; then
  $convbkmk -gd fig-p-dpdx-euc.dvispc && diff -q $testdir/fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-euc-convbkmk.dvispc || rc=305
else
  $convbkmk -gd fig-p-dpdx-sjis.dvispc && diff -q $testdir/fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-sjis-convbkmk.dvispc || rc=306
fi

$convbkmk -edO fig-p-dpdx-euc.dvispc && diff -q $testdir/fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-euc.dvispc || rc=307
$convbkmk -sdO fig-p-dpdx-sjis.dvispc && diff -q $testdir/fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-sjis.dvispc || rc=308


exit $rc

