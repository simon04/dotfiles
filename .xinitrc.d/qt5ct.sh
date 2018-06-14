#!/bin/bash

# https://wiki.archlinux.org/index.php/Qt#Configuration_of_Qt5_apps_under_environments_other_than_KDE_Plasma
if [ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
  exit
fi
if [[ -x /usr/bin/qt5ct ]]; then
  export QT_QPA_PLATFORMTHEME="qt5ct"
fi
