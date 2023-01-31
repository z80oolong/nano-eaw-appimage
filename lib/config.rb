module Config
  module_function

  def stable_version?
    return true
  end

  def current_vm_provider
    return "lxc"
    #return "libvirt"
  end

  def current_libvirt_driver
    return "qemu"
    #return "kvm"
  end

  def appimage_tap_name
    return "z80oolong/appimage"
  end

  def current_tap_name
    return "z80oolong/eaw"
  end

  def current_formula_name
    return "nano"
  end

  def current_builder_name
    return "nano-builder"
  end

  def current_appimage_name
    return "#{current_formula_name}-eaw"
  end

  def current_version_list
    if stable_version? then
      return ["7.2"]
    else
      return ["HEAD-#{commit}"]
    end
  end

  def all_stable_version
    return %w[4.9.2 4.9.3 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.6.1 5.7 5.8 5.9 6.0 6.1 6.2 6.3 6.4 7.0 7.1 7.2]
  end

  def current_head_formula_version
    return "8.0-next"
  end

  def all_stable_formulae
    return all_stable_version.map do |v|
      "#{Config::current_tap_name}/#{Config::current_formula_name}@#{v}"
    end
  end

  def current_head_formula
    return "#{lib_dir}/#{current_formula_name}@#{current_head_formula_version}.rb"
  end

  def commit_long
    return "1c307bc1be2906f10f7a4430f7603a3c620fb064"
  end

  def commit
    return commit_long[0..7]
  end

  def current_appimage_revision
    return 51
  end

  def release_dir
    return "/vagrant/opt/releases"
  end

  def lib_dir
    return "/vagrant/lib"
  end

  def appimage_arch
    return "x86_64"
  end
end
