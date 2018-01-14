function adb-ls
    adb shell ls $argv | tr '\r' ' '
end
