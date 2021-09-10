function prep-shot --description 'Prepares a screenshot for uploading'
    mogrify -trim $argv
    oxipng --opt max $argv
end
