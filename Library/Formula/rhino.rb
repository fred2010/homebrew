require 'formula'
require 'ftools'
require 'fileutils'

class Rhino <Formula
  url 'ftp://ftp.mozilla.org/pub/mozilla.org/js/rhino1_7R2.zip'
  homepage 'https://www.mozilla.org/rhino/'
  md5 '40d0a9abec8169e42920214b37fa8e0e'


  def install
    bindir=File.join(prefix,"bin")
    libdir=File.join(prefix,"libexec")
    sharedir=File.join(prefix,"share","rhino")
    [bindir,libdir,sharedir].each{|d| File.directory?(d) or File.makedirs(d)}
    fcontent=%Q{#!/bin/sh\njava -jar #{libdir}/js.jar}
     File.open(File.join(bindir,"rhino"),'w'){|f|f.write(fcontent)}
     File.chmod(0755,File.join(bindir,"rhino"))

    %w{js.jar js-14.jar}.each{|jar| File.copy(jar,File.join(libdir,jar))}
    cp_r("javadoc/",sharedir)

  end
end
