#!/bin/sh
rm -f ./opt/releases/*.AppImage ./opt/formula/*.rb
vagrant up --provision 2>&1 | tee build-appimage-nano.log
vagrant halt
