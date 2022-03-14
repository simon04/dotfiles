function prep-shot --description 'Prepares a screenshot for uploading'
    echo ">>> Preparing screenshots $argv"
    mogrify -trim $argv
    oxipng --opt max $argv
end
