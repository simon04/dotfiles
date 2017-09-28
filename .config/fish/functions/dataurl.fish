function dataurl --description 'Converts files to data URL'
    for filename in $argv
        set mimetype (file -b --mime-type $filename)
        and set encoded (base64 -w 0 $filename)
        and echo "data:$mimetype;base64,$encoded"
    end
end
