function adb-mv
    adb-ls "$1" | xargs -i -n1 adb shell mv -i {} "$2"
end
