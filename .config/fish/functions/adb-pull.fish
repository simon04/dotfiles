function adb-pull
    adb-ls $argv | xargs -n1 adb pull
end
