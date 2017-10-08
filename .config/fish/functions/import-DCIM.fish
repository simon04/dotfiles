function import-DCIM --description 'Imports images from memory cards' --argument-names dir
    if not count $dir >/dev/null
        set -x dir /run/media/simon/disk/DCIM/100MSDCF/
    end
    for file in (find $dir -iname '*.jpg')
        set -x date (jhead $file | grep 'Date/Time' | grep -Eo '[0-9]{4}:[0-9]{2}:[0-9]{2}' | tr : -)
        set -x year (string sub -s 1 -l 4 $date)
        set -x target $HOME/Fotos/$year/$date
        mkdir --parents $target
        and mv --interactive --verbose $file $target
    end
end
