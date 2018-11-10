UPLATEX = uplatex
PLATEX = platex
DVIPS = dvips
DVIPDFMX = dvipdfmx
PS2PDF = ps2pdf

#CONVBKMKRB = /usr/bin/convbkmk
CONVBKMKRB = ../convbkmk.rb
CONVBKMK   = $(CONVBKMKRB)

platex_dvips:
	cp bkmk-dpps.tex bkmk-p-dpps.tex
	$(PLATEX) bkmk-p-dpps.tex
	$(PLATEX) bkmk-p-dpps.tex
	$(DVIPS) bkmk-p-dpps.dvi
	$(CONVBKMK) -g bkmk-p-dpps.ps
	$(PS2PDF) bkmk-p-dpps-convbkmk.ps

uplatex_dvips:
	cp bkmk-dpps.tex bkmk-up-dpps.tex
	$(UPLATEX) bkmk-up-dpps.tex
	$(UPLATEX) bkmk-up-dpps.tex
	$(DVIPS) bkmk-up-dpps.dvi
	$(CONVBKMK) -g bkmk-up-dpps.ps
	$(PS2PDF) bkmk-up-dpps-convbkmk.ps

platex_dvipdfmx: bkmk_docinfo
	cp bkmk-dpdx.tex bkmk-p-dpdx.tex
	$(PLATEX) bkmk-p-dpdx.tex
	$(PLATEX) bkmk-p-dpdx.tex
	cp bkmk-p-dpdx.out bkmk-p-dpdx_bak.out
	$(CONVBKMK) -o bkmk-p-dpdx.out
	cp bkmk-p-dpdx.out bkmk-p-dpdx_cnvt.out
	$(PLATEX) bkmk-p-dpdx.tex
	$(DVIPDFMX) bkmk-p-dpdx.dvi

uplatex_dvipdfmx: bkmk_docinfo
	cp bkmk-dpdx.tex bkmk-up-dpdx.tex
	$(UPLATEX) bkmk-up-dpdx.tex
	$(UPLATEX) bkmk-up-dpdx.tex
	cp bkmk-up-dpdx.out bkmk-up-dpdx_bak.out
	$(CONVBKMK) -o bkmk-up-dpdx.out
	cp bkmk-up-dpdx.out bkmk-up-dpdx_cnvt.out
	$(UPLATEX) bkmk-up-dpdx.tex
	$(DVIPDFMX) bkmk-up-dpdx.dvi

bkmk_docinfo: bkmk-docinfo.txt
	cp bkmk-docinfo.txt bkmk-docinfo.out
	cp bkmk-docinfo.out bkmk-docinfo_bak.out
	$(CONVBKMK) -o bkmk-docinfo.out

test_samples:
	nkf -e bkmk-p-dpps.ps > bkmk-p-dpps-euc.ps
	nkf -s bkmk-p-dpps.ps > bkmk-p-dpps-sjis.ps

clean:
	rm -f *.dvi *.aux *.log
	rm -f *.ps *.pdf
	rm -f bkmk-p-dpps.tex bkmk-up-dpps.tex bkmk-p-dpdx.tex bkmk-up-dpdx.tex
	rm -f *.out


