class NanoBuilder < AppImage::Builder
  # For brew appimage-build
  def apprun; <<~EOS
    #!/bin/sh
    #export APPDIR="/tmp/.mount-nanoXXXXXX"
    if [ "x${APPDIR}" = "x" ]; then
      export APPDIR="$(dirname "$(readlink -f "${0}")")"
    fi

    if [ "x${HOMEBREW_PREFIX}" = "x" ]; then
      export LD_LIBRARY_PATH="${APPDIR}/usr/lib/:${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      export PATH="${APPDIR}/usr/bin/:${HOMEBREW_PREFIX}/bin/:${PATH:+:$PATH}"
      export XDG_DATA_DIRS="${APPDIR}/usr/share/:${HOMEBREW_PREFIX}/share/:${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    else
      export LD_LIBRARY_PATH="${APPDIR}/usr/lib/:${HOMEBREW_PREFIX}/lib/:${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      export PATH="${APPDIR}/usr/bin/:${PATH:+:$PATH}"
      export XDG_DATA_DIRS="${APPDIR}/usr/share/:${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    fi

    export TERMINFO="${APPDIR}/usr/share/terminfo"
    export LOCALEDIR="${APPDIR}/usr/share/locale"
    export MAGIC="${APPDIR}/usr/share/misc"
    unset ARGV0

    exec "nano" "$@"
    EOS
  end

  def exec_path_list
    return [opt_bin/"nano"]
  end

  def pre_build_appimage(appdir, verbose)
    system("cp -pRv #{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_share}/terminfo #{appdir.share}")
    system("cp -pRv #{Formula[full_name].opt_share}/locale #{appdir.share}")
    system("cp -pRv #{Formula["libmagic"].opt_share}/misc #{appdir.share}")
  end
end
