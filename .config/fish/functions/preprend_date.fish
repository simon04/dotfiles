function prepend_date --description 'Prepends ISO 8601 date to files'
    for i in $argv
        mv -v $i (date -I)" $i"
    end
end
