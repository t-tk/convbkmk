convbkmk Ver.0.30
=================

2018.11.25

Takuji Tanaka
<ttk(at)t-lab.opal.ne.jp>

http://www.t-lab.opal.ne.jp/tex/uptex_en.html


## Abstract

convbkmk is a tiny utility for making correct bookmarks in pdf files
typesetted by pLaTeX/upLaTeX with the hyperref package.
pLaTeX/upLaTeX + hyperref outputs data of bookmarks
in their internal encodings (EUC-JP, Shift_JIS or UTF-8).
On the other hand, the PostScript/PDF format requests that
the data are written in a certain syntax with UTF-16 or PDFDocEncoding.
Thus, data conversion is required to create correct bookmarks.

In addition, pLaTeX outputs dvi files with special commands
in its internal encoding (EUC-JP or Shift_JIS).
It is not consistent with recent dviware and file systems
which assume UTF-8.

convbkmk provides a function of
the encoding conversion and formatting the data.


## Repository

convbkmk is maintained on GitHub:
https://github.com/t-tk/convbkmk


## Licence

Lisence notice is written in the convbkmk.rb.
It is as same as the MIT license.
Ref. http://opensource.org/licenses/MIT


## More information

More information is within the convbkmk.rb with the RD format.
