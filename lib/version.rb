module NanoM
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
    return "18ba7f60c165d271d7734cc18a4c5001cb9efb32"
  end

  def commit
    return commit_long[0..7]
  end

  COMMIT_SHA256 = %x{curl -s -L -o - https://github.com/ahjragaas/nano/archive/#{commit_long}.tar.gz | sha256sum -}.chomp.gsub(/^([0-9a-f]*).*/) { $1 } 

  def commit_sha256
    return COMMIT_SHA256
  end

  def head_version
    return "6.3-next"
  end

  def appimage_version
    return "v#{stable_version}-eaw-appimage-0.1.0"
  end

  def appimage_revision
    return 0
  end

  def release_dir
    "/vagrant/opt/releases"
  end

  def formula_dir
    "/vagrant/opt/formula"
  end

  def lib_dir
    "/vagrant/lib"
  end
end
