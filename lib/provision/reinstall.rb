Vagrant.configure("2") do |config|
  nano_versions = NanoM::stable_version_list + NanoM::devel_version_list

  config.vm.provision "shell", privileged: true, inline: "sudo apt-get update"
  config.vm.provision "shell", privileged: true, inline: "sudo apt-get -y upgrade"

  config.vm.provision "shell", privileged: false, inline: "brew remove --force nano@#{NanoM::head_version}"
  config.vm.provision "shell", privileged: false, inline: "brew doctor"
  config.vm.provision "shell", privileged: false, inline: "brew update"
  config.vm.provision "shell", privileged: false, inline: "brew upgrade"

  nano_versions.each do |v|
    config.vm.provision "shell", privileged: false, inline: "brew reinstall z80oolong/eaw/nano@#{v}"
  end
  config.vm.provision "shell", privileged: false, inline: "brew reinstall --formula #{NanoM::lib_dir}/nano@#{NanoM::head_version}.rb"
end
