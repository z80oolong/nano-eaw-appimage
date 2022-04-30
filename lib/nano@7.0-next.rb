$:.unshift((Pathname.new(__FILE__).dirname/"..").realpath.to_s)

require "lib/config"

class NanoAT70Next < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "https://www.nano-editor.org/"
  license "GPL-3.0-or-later"

  stable do
    nano_version = "HEAD-#{Config::commit}"
    url "https://git.savannah.gnu.org/cgit/nano.git/snapshot/nano-#{Config::commit_long}.tar.gz"
    sha256 Config::commit_sha256
    version nano_version

    patch :p1, Formula["z80oolong/eaw/nano"].diff_data

    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "texinfo"  => :build
  end

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

    fix_rpath "#{bin}/nano", ["z80oolong/eaw/ncurses-eaw@6.2"], ["ncurses"]
    doc.install "doc/sample.nanorc"
  end

  def fix_rpath(binname, append_list, delete_list)
    return unless OS.linux?

    delete_list_hash = {}
    rpath = %x{#{Formula["patchelf"].opt_bin}/patchelf --print-rpath #{binname}}.chomp.split(":")

    (append_list + delete_list).each {|name| delete_list_hash["#{Formula[name].opt_lib}"] = true}
    rpath.delete_if {|path| delete_list_hash[path]}
    append_list.each {|name| rpath.unshift("#{Formula[name].opt_lib}")}

    system "#{Formula["patchelf"].opt_bin}/patchelf", "--set-rpath", "#{rpath.join(":")}", "#{binname}"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end
