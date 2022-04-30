module Config
  module_function

  def stable_version_list
    return %w(4.9.2 4.9.3 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.6.1 5.7 5.8 5.9 6.0 6.1 6.2)
  end

  def stable_version
    return stable_version_list[-1]
  end

  def devel_version_list
    return []
  end

  def devel_version
    return ""
  end

  def commit_long
    return "450bfa7a757424aab18df7568931f322e733671a"
  end

  def commit
    return commit_long[0..7]
  end

  def commit_sha256
    @@curl ||= %x{which curl}.chomp!
    @@sha256sum ||= %x{which sha256sum}.chomp!
    @@archive_url ||= "https://git.savannah.gnu.org/cgit/nano.git/snapshot"
    @@commit_sha256 ||= %x{#{@@curl} -s -L -o - #{@@archive_url}/nano-#{commit_long}.tar.gz | #{@@sha256sum} -}.chomp.gsub(/^([0-9a-f]*).*/) { $1 }
    return @@commit_sha256
  end

  def head_version
    return "7.0-next"
  end

  def appimage_version
    return "v#{stable_version}-eaw-appimage-0.1.0"
  end

  def appimage_revision
    return 36
  end

  def release_dir
    return "/vagrant/opt/releases"
  end

  def formula_dir
    return "/vagrant/opt/formula"
  end

  def lib_dir
    return "/vagrant/lib"
  end

  def appimage_builder_rb
    return "nano-builder.rb"
  end

  def appimage_name
    return "nano-eaw"
  end

  def appimage_command
    return "nano"
  end

  def appimage_arch
    return "x86_64"
  end

  def formula_tap
    return "z80oolong/eaw"
  end

  def formula_name
    return "nano"
  end

  def formula_fullname
    return "#{formula_tap}/#{formula_name}"
  end

  def formula_desc
    return "AppImage package of Free (GNU) replacement for the Pico text editor."
  end

  def formula_homepage
    return "https://www.nano-editor.org/"
  end

  def formula_download_url
    return "https://github.com/z80oolong/nano-eaw-appimage/releases/download"
  end
end
