function prep-shot --description 'Prepares a screenshot for uploading'
    gm mogrify -trim $argv
    oxipng --opt max $argv
end
