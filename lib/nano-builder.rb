class NanoBuilder < AppImage::Builder
  # For brew appimage-build
  def apprun; <<~EOS
    #!/bin/sh
    #export APPDIR="/tmp/.mount-nanoXXXXXX"
    if [ "x${APPDIR}" = "x" ]; then
      export APPDIR="$(dirname "$(readlink -f "${0}")")"
    fi

    if [ "x${HOMEBREW_PREFIX}" = "x" ]; then
      export PATH="${APPDIR}/usr/bin/:${HOMEBREW_PREFIX}/bin/:${PATH:+:$PATH}"
      export XDG_DATA_DIRS="${APPDIR}/usr/share/:${HOMEBREW_PREFIX}/share/:${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    else
      export PATH="${APPDIR}/usr/bin/:${PATH:+:$PATH}"
      export XDG_DATA_DIRS="${APPDIR}/usr/share/:${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    fi

    export TERMINFO="${APPDIR}/usr/share/terminfo"
    export LOCALEDIR="${APPDIR}/usr/share/locale"
    export MAGIC="${APPDIR}/usr/share/misc"
    unset ARGV0

    NANO="${APPDIR}/usr/bin/nano"
    LDSO="${APPDIR}/usr/bin/ld.so"

    if [ -x "${LDSO}" ] ; then
      exec "${LDSO}" "${NANO}" "$@"
    else
      exec "${NANO}" "$@"
    fi
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
