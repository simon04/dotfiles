function prep-shot --description 'Prepares a screenshot for uploading'
    gm mogrify -trim $argv
    optipng $argv
end
