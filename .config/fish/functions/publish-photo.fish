function publish-photo
    jhead -autorot $argv
    gm mogrify -verbose -quality 70 -resize 1920x1920 $argv
    exiftool -Author='Simon Legner' '-DateTimeOriginal>FileModifyDate' -overwrite_original $argv
end
