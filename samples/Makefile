UPLATEX = uplatex
PLATEX = platex
DVIPS = dvips
DVIPDFMX = dvipdfmx
PS2PDF = ps2pdf
DVISPC = dvispc

#CONVBKMKRB = /usr/bin/convbkmk
CONVBKMKRB = ../convbkmk.rb
CONVBKMK   = $(CONVBKMKRB)

all: dvips dvipdfmx
dvips: platex_dvips uplatex_dvips
dvipdfmx: platex_dvipdfmx uplatex_dvipdfmx

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


fig_platex_dvips:
	cp fig-dpps.tex fig-p-dpps.tex
	$(PLATEX) fig-p-dpps.tex
	$(PLATEX) fig-p-dpps.tex
	$(DVISPC) -a fig-p-dpps.dvi fig-p-dpps.dvispc
	$(CONVBKMK) -d -g fig-p-dpps.dvispc
	$(DVISPC) -x fig-p-dpps-convbkmk.dvispc fig-p-dpps-convbkmk.dvi
	$(DVIPS) fig-p-dpps-convbkmk.dvi
	$(PS2PDF) fig-p-dpps-convbkmk.ps

fig_uplatex_dvips:
	cp fig-dpps.tex fig-up-dpps.tex
	$(UPLATEX) fig-up-dpps.tex
	$(UPLATEX) fig-up-dpps.tex
	$(DVIPS) fig-up-dpps.dvi
	$(PS2PDF) fig-up-dpps.ps

fig_platex_dvipdfmx:
	cp fig-dpdx.tex fig-p-dpdx.tex
	$(PLATEX) fig-p-dpdx.tex
	$(PLATEX) fig-p-dpdx.tex
	$(DVISPC) -a fig-p-dpdx.dvi fig-p-dpdx.dvispc
	$(CONVBKMK) -d -g fig-p-dpdx.dvispc
	$(DVISPC) -x fig-p-dpdx-convbkmk.dvispc fig-p-dpdx-convbkmk.dvi
	$(DVIPDFMX) fig-p-dpdx-convbkmk.dvi

fig_uplatex_dvipdfmx:
	cp fig-dpdx.tex fig-up-dpdx.tex
	$(UPLATEX) fig-up-dpdx.tex
	$(UPLATEX) fig-up-dpdx.tex
	$(DVIPDFMX) fig-up-dpdx.dvi


test_samples:
	nkf -e bkmk-p-dpps.ps > bkmk-p-dpps-euc.ps
	nkf -s bkmk-p-dpps.ps > bkmk-p-dpps-sjis.ps

clean:
	rm -f *.dvi *.aux *.log
	rm -f *.ps *.pdf
	rm -f bkmk-p-dpps.tex bkmk-up-dpps.tex bkmk-p-dpdx.tex bkmk-up-dpdx.tex
	rm -f *.out
	rm -f fig-p-dpps.tex fig-up-dpps.tex fig-p-dpdx.tex fig-up-dpdx.tex
	rm -f *.dvispc


doc:
	pandoc ../README.md -s -o README_convbkmk.html
	rd2 ../convbkmk.rb > convbkmk.html
