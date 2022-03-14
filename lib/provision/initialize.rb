Vagrant.configure("2") do |config|
  nano_versions = NanoM::stable_version_list + NanoM::devel_version_list
  nanos = (nano_versions.map {|v| "z80oolong/eaw/nano@#{v}" }).join(" ")

  config.vm.provision "shell", privileged: false, inline: %[
    if [ ! -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
      sudo apt-get update && \
      sudo apt-get -y upgrade && \
      sudo apt-get -y install build-essential ruby && \
      env NONINTERACTIVE=1 \
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
      echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile && \
      echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc  && \
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
      brew install gcc && \
      brew tap z80oolong/appimage && \
      brew tap z80oolong/eaw && \
      brew install --only-dependencies #{nanos} && \
      brew install --only-dependencies --formula #{NanoM::lib_dir}/nano@#{NanoM::head_version}.rb
    fi
  ]
end
