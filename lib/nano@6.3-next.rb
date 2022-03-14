$:.unshift((Pathname.new(__FILE__).dirname/"..").realpath.to_s)

require "lib/version"

class NanoAT63Next < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "https://www.nano-editor.org/"

  stable do
    nano_version = "HEAD-#{NanoM::commit}"
    url "https://github.com/ahjragaas/nano/archive/#{NanoM::commit_long}.tar.gz"
    sha256 NanoM::commit_sha256
    version nano_version

    def pick_diff(formula_path)
      lines = formula_path.each_line.to_a.inject([]) do |result, line|
        result.push(line) if ((/^__END__/ === line) || result.first)
        result
      end
      lines.shift
      return lines.join("")
    end

    patch :p1, pick_diff(Formula["z80oolong/eaw/nano"].path)
  end

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "texinfo"  => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "z80oolong/eaw/ncurses-eaw@6.2"

  on_linux do
    depends_on "patchelf" => :build
  end

  depends_on "libmagic" unless OS.mac?

  def install
    ENV.append "CFLAGS",     "-I#{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_include}"
    ENV.append "CPPFLAGS",   "-I#{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_include}"
    ENV.append "LDFLAGS",    "-L#{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_lib}"

    system "sh", "autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-color",
                          "--enable-extra",
                          "--enable-multibuffer",
                          "--enable-nanorc",
                          "--enable-utf8"
    system "make", "install"

    if OS.linux? then
      fix_rpath "#{bin}/nano", ["z80oolong/eaw/ncurses-eaw@6.2"], ["ncurses"]
    end

    doc.install "doc/sample.nanorc"
  end

  def fix_rpath(binname, append_list, delete_list)
    delete_list_hash = {}
    rpath = %x{#{Formula["patchelf"].opt_bin}/patchelf --print-rpath #{binname}}.chomp.split(":")

    (append_list + delete_list).each {|name| delete_list_hash["#{Formula[name].opt_lib}"] = true}
    rpath.delete_if {|path| delete_list_hash[path]}
    append_list.each {|name| rpath.unshift("#{Formula[name].opt_lib}")}

    system "#{Formula["patchelf"].opt_bin}/patchelf", "--set-rpath", "#{rpath.join(":")}", "#{binname}"
  end

  # For brew appimage-build
  def apprun; <<~EOS
    #!/bin/sh
    #export APPDIR="/tmp/.mount-nanoXXXXXX"
    if [ "x${APPDIR}" = "x" ]; then
      export APPDIR="$(dirname "$(readlink -f "${0}")")"
    fi
    export PATH="${APPDIR}/usr/bin/:${PATH:+:$PATH}"
    export LD_LIBRARY_PATH="${APPDIR}/usr/lib/:${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    export XDG_DATA_DIRS="${APPDIR}/usr/share/${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    export TERMINFO="${APPDIR}/usr/share/terminfo"
    unset ARGV0

    exec "nano" "$@"
    EOS
  end

  def exec_path_list
    return [opt_bin/"nano"]
  end

  def pre_build_appimage(appdirpath, verbose)
    system("cp -pRv #{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_share}/terminfo #{appdirpath}/usr/share")
  end

  test do
    system "#{bin}/nano", "--version"
  end
end
