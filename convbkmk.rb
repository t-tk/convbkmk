#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

=begin

= convbkmk Ver.0.20

  2018.11.11
  Takuji Tanaka
  ttk (at) t-lab.opal.ne.jp
((<URL:http://www.t-lab.opal.ne.jp/tex/uptex_en.html>))


== Abstract

((*convbkmk*)) is a tiny utility for making correct bookmarks in pdf files
typesetted by platex/uplatex with the hyperref package.
platex/uplatex + hyperref outputs data of bookmarks
in their internal encodings (EUC-JP, Shift_JIS or UTF-8).
On the other hand, the PostScript/PDF format requests that
the data is written in a certain syntax with UTF-16 or PDFDocEncoding.
Thus, data conversion is required to create correct bookmarks.
((*convbkmk*)) provides a function of
the encoding conversion and formatting the bookmark data.

== Requirement

ruby 1.9.x or later is required.
ruby 1.8.x is no longer supported.

== Examples

platex (internal kanji code: euc) + hyperref + dvips :
 $ platex doc00.tex
 $ platex doc00.tex
 $ dvips doc00.dvi
 $ convbkmk.rb -e doc00.ps
 $ ps2pdf doc00-convbkmk.ps

platex (kanji code: sjis) + hyperref + dvipdfmx :
 $ platex doc01.tex
 $ platex doc01.tex
 $ convbkmk.rb -s -o doc01.out
 $ platex doc01.tex
 $ dvipdfmx doc01.dvi

uplatex + hyperref + dvips :
 $ uplatex doc02.tex
 $ uplatex doc02.tex
 $ dvips doc02.dvi
 $ convbkmk.rb doc02.ps
 $ ps2pdf doc02-convbkmk.ps

uplatex + hyperref + dvipdfmx :
 $ uplatex doc03.tex
 $ uplatex doc03.tex
 $ convbkmk.rb -o doc03.out
 $ uplatex doc03.tex
 $ dvipdfmx doc03.dvi

More examples are included in the uptex source archive.

== Repository

convbkmk is maintained on GitHub:
((<URL:https://github.com/t-tk/convbkmk>))

== License

convbkmk

Copyright (c) 2009-2018 Takuji Tanaka

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

== History

: 2009.08.02  0.00
 * Initial version.
: 2011.05.02  0.01
 * Bug fix: BOM was not correct.
: 2012.05.08  0.02
 * Bug fix: for a case of dvips with -z option and Ruby1.8.
 * Add conversion of /Creator and /Producer .
: 2012.05.12  0.03
 * Suppress halfwidth -> fullwidth katakana conversion and MIME decoding in Ruby1.8.
: 2012.06.01  0.04
 * Support escape sequences: \n, \r, \t, \b, \f, \\, \ddd (octal, PDFDocEncoding) and \0xUUUU (Unicode UTF-16BE).
 * Support sequences of end of line: '\' or other followed by "\n", "\r\n" or "\r" .
 * Set file IO to binary mode.
: 2012.07.26  0.05
 * Add -o option to support conversion of OUT files generated by dvipdfmx.
: 2012.08.07  0.06
 * Bug fix: Ver.0.05 does not work with Ruby1.9.
: 2012.09.17  0.07
 * Bug fix: An infinite loop occurs in Ver.0.05, 0.06 with -g option in some cases.
 * Add reference for PDFDocEncoding.
: 2013.05.11  0.08
 * Add -O option: overwrite output files onto input files instead of creating foo-convbkmk.ps .
 * Make comments rd/rdtool friendly.
: 2014.03.02  0.09
 * Bug fix: Conversion was not complete in some cases.
: 2014.03.08  0.10
 * Bug fix: Output of binary data might be broken in filter mode on Windows.
: 2014.12.29  0.10a
 * Update the author's mail address and web site.
: 2018.11.11  0.20
 * Do not support Ruby1.8 anymore.

=end

Version = "0.20"

require "optparse"

if RUBY_VERSION < "1.9"
  abort("Ruby 1.8 or earlier is no longer supported.")
end

class String
  def to_utf8(enc)
    self.force_encoding(enc.current).encode('UTF-8')
  end
  def utf16be_to_utf8
    self.force_encoding('UTF-16BE').encode('UTF-8')
  end
  def utf8_to_utf16be
    self.force_encoding('UTF-8').encode('UTF-16BE')
  end
end

class TeXEncoding
  attr_accessor :current, :option, :status, :is_8bit
  attr_reader :list

  def initialize
    @current = false
    @option = false
    @status = false
    @is_8bit = false
    @list = ['Shift_JIS', 'EUC-JP', 'UTF-8']
  end

  def set_process_encoding(enc)
    if @status == 'fixed'
      raise 'dupulicate definition'
    end
    if enc == 'guess'
      @option = 'guess'
      @status = 'guess'
    else
      @current = enc
      @option = enc
      @status = 'fixed'
    end
    return enc
  end
end
enc = TeXEncoding.new

Opts = {}

OptionParser.new do |opt|
  opt.on('-e', '--euc-jp',
         'set pTeX internal encoding to EUC-JP') {|v|
    enc.set_process_encoding('EUC-JP')
  }
  opt.on('-s', '--shift_jis',
         'set pTeX internal encoding to Shift_JIS') {|v|
    enc.set_process_encoding('Shift_JIS')
  }
  opt.on('-u', '--utf-8',
         'set upTeX internal encoding to UTF-8') {|v|
    enc.set_process_encoding('UTF-8')
  }
  opt.on('-g', '--guess',
         'guess pTeX/upTeX internal encoding') {|v|
    enc.set_process_encoding('guess')
  }
  enc_alias = Hash.new
  enc.list.each { |e|
    enc_alias[e] = e
    enc_alias[e[0]] = e
    enc_alias[e.downcase] = e
  }
  opt.on('--enc=ENC', enc_alias,
         'set pTeX/upTeX internal encoding to ENC') {|v|
    enc.set_process_encoding(v)
  }
  opt.on('-o', '--out',
         'treat OUT files') {|v|
    Opts[:mode] = :out
    Opts[:overwrite] = true
    require "fileutils"
  }
  opt.on('-d', '--dvi-special',
         'treat specials in DVI files') {|v|
    Opts[:mode] = :spc
    require "fileutils"
  }
  opt.on('-O', '--overwrite',
         'overwrite output files') {|v|
    Opts[:overwrite] = true
    require "fileutils"
  }
  opt.banner += " file0.ps [file1.ps ...]\n" \
    + opt.banner.sub('Usage:','      ') + " < in_file.ps > out_file.ps\n" \
    + opt.banner.sub('Usage:','      ') + ' -o file0.out [file1.out ...]'

  opt.parse!
end

# default encoding
if enc.status == false
  enc.set_process_encoding('UTF-8')
end
if Opts[:mode] == :out
  OpenP, CloseP, OpenPEsc, ClosePEsc = '{', '}', '\{', '\}'
  FileSfx = 'out'
elsif Opts[:mode] == :spc then
  FileSfx = 'dvi|dvispc'
else
  OpenP, CloseP, OpenPEsc, ClosePEsc = '(', ')', '\(', '\)'
  FileSfx = 'ps'
end

def try_guess_encoding(line, enc)
  return 'US-ASCII' if line.ascii_only?

  enc.is_8bit = true
  valid_enc = false
  count = 0
  enc.list.each { |e|
    if line.dup.force_encoding(e).valid_encoding?
      count += 1
      valid_enc = e
    end
  }
  if count == 1
    enc.set_process_encoding(valid_enc)
    return valid_enc
  elsif count > 1
    return false # ambiguous
  else
    raise 'Cannot guess encoding!'
  end
end


def check_parentheses_balance(line, enc)
  depth = 0
  count = 0
  tmp_prev = ''
  tmp_rest = line

  if enc.status == 'guess'
    if tmp_enc = try_guess_encoding(line, enc)
      # succeeded in guess or ascii only
      tmp_rest = line.force_encoding(tmp_enc)
    else
      # ambiguous
      raise 'unexpected internal condition!'
    end
  else
    tmp_enc = enc.current
    tmp_rest = tmp_rest.force_encoding(tmp_enc)
    unless tmp_rest.valid_encoding?
      # illegal input
      $stdout = STDERR
      p 'parameters: '
      p '  status: ' + enc.status
      p '  option: ' + enc.option
      p '  current: ' + enc.current
      p enc.is_8bit
      p '             [' + line + ']'
      raise 'encoding is not consistent'
    end
  end

  while tmp_rest.length>0 do
    if    (tmp_rest =~ /\A(\\#{OpenPEsc}|\\#{ClosePEsc}|[^#{OpenP}#{CloseP}])*(#{OpenPEsc}|#{ClosePEsc})/o) # parenthis
      if $2 == OpenP
        depth += 1
        count += 1
      else
        depth -= 1
      end
      tmp_prev += $&
      tmp_rest = $'
    else
      tmp_prev += tmp_rest
      tmp_rest = ''
    end
    if depth<1
      break
    end
  end
  return depth, count, tmp_prev, tmp_rest
end

# PDFDocEncoding -> UTF-16BE
# Ref. "PDF Reference, Sixth Edition, version 1.7", 2006, Adobe Systems Incorporated
#   http://www.adobe.com/devnet/pdf/pdf_reference_archive.html
#   http://www.adobe.com/content/dam/Adobe/en/devnet/acrobat/pdfs/pdf_reference_1-7.pdf
PDF2UNI = Array(0..255)
PDF2UNI[0o030..0o037] = 0x02d8, 0x02c7, 0x02c6, 0x02d9, 0x02dd, 0x02db, 0x02da, 0x02dc
PDF2UNI[0o200..0o207] = 0x2022, 0x2020, 0x2021, 0x2026, 0x2014, 0x2013, 0x0192, 0x2044
PDF2UNI[0o210..0o217] = 0x2039, 0x203a, 0x2212, 0x2030, 0x201e, 0x201c, 0x201d, 0x2018
PDF2UNI[0o220..0o227] = 0x2019, 0x201a, 0x2122, 0xfb01, 0xfb02, 0x0141, 0x0152, 0x0160
PDF2UNI[0o230..0o237] = 0x0178, 0x017d, 0x0131, 0x0142, 0x0153, 0x0161, 0x017e, 0xfffd
PDF2UNI[0o240       ] = 0x20ac
PDF2UNI[0o255       ] = 0xfffd

def conv_string_to_utf16be(line, enc)
  if line !~ /(#{OpenPEsc})(.*)(#{ClosePEsc})/mo
    raise 'illegal input!'
  end
  pre, tmp, post = $`, $2, $'

  if tmp.ascii_only? && tmp !~ /\\0x[0-9A-F]{4}/i
    return line
  end

  conv = ''
  conv.force_encoding('UTF-8')
  tmp.force_encoding(enc.current)

  while tmp.length>0 do
    case tmp
    when /\A[^\\\n\r]+/
      conv += $&.to_utf8(enc)
    when /\A\\([0-3][0-7][0-7])/  # PDFDocEncoding -> UTF-8
      conv += [PDF2UNI[$1.oct]].pack("U*")
    when /\A\\0x(D[8-B][0-9A-F]{2})\\0x(D[C-F][0-9A-F]{2})/i  # surrogate pair
      conv += [$1.hex, $2.hex].pack("n*").utf16be_to_utf8
    when /\A\\0x([0-9A-F]{4})/i
      conv += [$1.hex].pack("U*")
    when /\A\\[nrtbf\\]/
      conv += eval(%!"#{$&}"!)
    when /\A(\r\n|\r|\n)/
      conv += "\n"
    when /\A\\([\r\n]{1,2})|\\/
      # ignore
    else
      raise 'unexpected input!'
    end
    tmp = $'
  end

  buf = ''
  conv16be = "\xFE\xFF"            # BOM U+FEFF
  conv16be.force_encoding('UTF-16BE')
  conv16be += conv.utf8_to_utf16be # UTF-16BE with BOM
  conv16be.each_byte {|byte|
    buf += (Opts[:mode] == :out ? '\%03o' : '%02X') % byte
  }
  buf = Opts[:mode] == :out ? '{' + buf + '}' : '<' + buf + '>'
  return pre + buf + post
end

def special_string_to_utf8(line, enc)
  if line.ascii_only? || line !~ /\Axxx[1-4]/mo
    return line, 0
  end

  if line !~ /\Axxx(\d) (\d+) '(.*)'([^']*)\Z/mo
    raise 'illegal input!'
  end
  xxx, bytes, str, trail = $1.to_i, $2.to_i, $3, $4
  if str.bytesize != bytes
    raise 'byte size is not consistent!'
  end
  if str !~ /\A(PS|ps)file=/mo
    return line, 0
  end

  conv = ''
  conv.force_encoding('UTF-8')

  str.force_encoding(enc.current)
  str = str.to_utf8(enc)
  bytes_new = str.bytesize

  xxx = bytes_new <= 0xff ? 1 : 4
  conv = 'xxx' + xxx.to_s + ' ' + bytes_new.to_s + " '" + str + "'" + trail
  return conv, bytes_new-bytes
end

def dvi_post_post(line, offset)
  if line !~ /\Apost_post (\d+) ([23](?: 223){4,7}.*)\Z/mo
    raise 'illegal input!'
  end
  bytes, trail = $1.to_i, $2
  bytes += offset
  line = 'post_post ' + bytes.to_s + ' ' + trail
  return line
end

def file_treatment(ifile, ofile, enc)
  ifile.set_encoding('ASCII-8BIT')
  ofile.set_encoding('ASCII-8BIT')

  line, offset = '', 0
  while l = ifile.gets do
    line.force_encoding('ASCII-8BIT')
    line += l
    if    Opts[:mode] == :out then
      reg = %r!(\{)!
    elsif Opts[:mode] == :spc then
      reg = %r!(\A(xxx|post_post))!
    else
      reg = %r!(/Title|/Author|/Keywords|/Subject|/Creator|/Producer)(\s+\(|$)!
    end
    if (line !~ reg )
      ofile.print line
      line = ''
      next
    end

    if Opts[:mode] == :spc
      if (line =~ /\Axxx/)
        line, diff = special_string_to_utf8(line, enc)
        offset += diff
      else
        line = dvi_post_post(line, offset)
      end
      ofile.print line
      line = ''
      next
    end

    ofile.print $`
    line = $& + $'

    if Opts[:mode] != :out
      while line =~ %r!(/Title|/Author|/Keywords|/Subject|/Creator|/Producer)\Z! do
        line += ifile.gets
      end
    end

    if enc.status == 'guess'
      if tmp_enc = try_guess_encoding(line, enc)
        # succeeded in guess or ascii only
        line.force_encoding(tmp_enc)
      else
        # ambiguous
        next
      end
    end

    while line.length>0 do
      depth, count, tmp_prev, tmp_rest \
        = check_parentheses_balance(line, enc)
      if depth<0
        p depth, count, tmp_prev, tmp_rest
        raise 'illegal input! (depth<0)'
      elsif depth>0
        break
      elsif count==0
        ofile.print line
        line = ''
        break
      elsif count>0
        ofile.print conv_string_to_utf16be(tmp_prev, enc)
        line = tmp_rest
      else
        p depth, count, tmp_prev, tmp_rest
        raise 'illegal input! (count<0)'
      end
    end

  end

  if enc.status == 'guess' && enc.is_8bit
    raise 'did not succeed in guess encoding!'
  end
end


### main
if ARGV.size == 0
  ifile = STDIN.binmode
  ofile = STDOUT.binmode
  file_treatment(ifile, ofile, enc)
else
  ARGV.each {|fin|
    if (fin !~ /\.#{FileSfx}$/io)
      raise 'input file does not seem ' + FileSfx.upcase + ' file'
    end
    fout = fin.gsub(/\.#{FileSfx}$/io, "-convbkmk#{$&}")
    open(fin, 'rb') {|ifile|
      open(fout, 'wb') {|ofile|
        file_treatment(ifile, ofile, enc)
      }
    }
    if (Opts[:overwrite])
      FileUtils.mv(fout, fin)
    end
  }
end

