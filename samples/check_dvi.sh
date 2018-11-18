# Copyright 2018 Takuji Tanaka <ttk@t-lab.opal.ne.jp>
# You may freely use, modify and/or distribute this file.

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

