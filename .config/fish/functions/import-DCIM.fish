function import-DCIM
    for file in /run/media/simon/disk/DCIM/100MSDCF/*.JPG
        set date (jhead $file | grep 'Date/Time' | grep -Eo '[0-9]{4}:[0-9]{2}:[0-9]{2}' | tr : -)
        set year (sub -s 1 -l 4 $date)
        set target $HOME/Fotos/$year/$date
        mkdir --parents $target
        and mv --interactive --verbose $file $target
    end
end
