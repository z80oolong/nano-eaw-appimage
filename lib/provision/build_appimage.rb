Vagrant.configure("2") do |config|
  NanoM::stable_version_list.each do |v|
    config.vm.provision "shell", privileged: false, inline: %[
      brew appimage-build -v -o ./nano-eaw-#{v}-x86_64.AppImage -r #{NanoM::lib_dir}/appimage-build/nano@#{v}.rb z80oolong/eaw/nano@#{v}
    ]
  end

  if NanoM::devel_version_list[0] then
    config.vm.provision "shell", privileged: false, inline: %[
      brew appimage-build -v -o ./nano-eaw-#{NanoM::devel_version}-x86_64.AppImage \
           -r #{NanoM::lib_dir}/appimage-build/nano@#{NanoM::devel_version_list[0]}.rb z80oolong/eaw/nano@#{NanoM::devel_version_list[0]}
    ]
  end

  config.vm.provision "shell", privileged: false, inline: %[
    brew appimage-build -v -o ./nano-eaw-HEAD-#{NanoM::commit}-x86_64.AppImage #{NanoM::lib_dir}/nano@#{NanoM::head_version}.rb
  ]

  config.vm.provision "shell", privileged: false, inline: "mv ./nano-eaw-*-x86_64.AppImage #{NanoM::release_dir}"
end
