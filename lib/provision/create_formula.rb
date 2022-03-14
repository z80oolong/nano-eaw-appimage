Vagrant.configure("2") do |config|
  NanoM::stable_version_list.each do |v|
    config.vm.provision "shell", privileged: false, inline: %[
      brew appimage-install -O -n appimage-nano@#{v} -c nano #{NanoM::release_dir}/nano-eaw-#{v}-x86_64.AppImage | \
        sed -e 's|#desc ".*"|desc "AppImage package of Free (GNU) replacement for the Pico text editor"|g' \
            -e 's|#homepage ".*"|homepage "https://www.nano-editor.org/"|g' \
            -e 's|url ".*"|url "https://github.com/z80oolong/nano-eaw-appimage/releases/download/#{NanoM::appimage_version}/nano-eaw-#{v}-x86_64.AppImage"|g' \
            -e 's|version ".*"|version "#{v}"|g' \
            -e 's|#revision 0|revision #{NanoM::appimage_revision}|g' \
	    > #{NanoM::formula_dir}/appimage-nano@#{v}.rb
    ]
  end

  if NanoM::devel_version_list[0] then
    v1dev = NanoM::devel_version
    v2dev = NanoM::devel_version_list[0]
    config.vm.provision "shell", privileged: false, inline: %[
      brew appimage-install -O -n appimage-nano@#{v2dev} -c nano #{NanoM::release_dir}/nano-eaw-#{v1dev}-x86_64.AppImage | \
        sed -e 's|#desc ".*"|desc "AppImage package of Free (GNU) replacement for the Pico text editor"|g' \
            -e 's|#homepage ".*"|homepage "https://www.nano-editor.org/"|g' \
            -e 's|url ".*"|url "https://github.com/z80oolong/nano-eaw-appimage/releases/download/#{NanoM::appimage_version}/nano-eaw-#{v1dev}-x86_64.AppImage"|g' \
            -e 's|version ".*"|version "#{v1dev}"|g' \
            -e 's|#revision 0|revision #{NanoM::appimage_revision}|g' \
            > #{NanoM::formula_dir}/appimage-nano@#{v2dev}.rb
    ]
  end

  vhead = "HEAD-#{NanoM::commit}"
  config.vm.provision "shell", privileged: false, inline: %[
    brew appimage-install -O -n appimage-nano@#{NanoM::head_version} -c nano #{NanoM::release_dir}/nano-eaw-#{vhead}-x86_64.AppImage | \
      sed -e 's|#desc ".*"|desc "AppImage package of Free (GNU) replacement for the Pico text editor"|g' \
          -e 's|#homepage ".*"|homepage "https://www.nano-editor.org/"|g' \
          -e 's|url ".*"|url "https://github.com/z80oolong/nano-eaw-appimage/releases/download/#{NanoM::appimage_version}/nano-eaw-#{vhead}-x86_64.AppImage"|g' \
          -e 's|version ".*"|version "#{vhead}"|g' \
          -e 's|#revision 0|revision #{NanoM::appimage_revision}|g' \
          > #{NanoM::formula_dir}/appimage-nano@#{NanoM::head_version}.rb
  ]
end
