# Defined in /tmp/fish.T2PFCD/scour-max.fish @ line 1
function scour-max
    set src $argv[1]
    set tmp (mktemp)
    scour --remove-descriptive-elements --enable-viewboxing --enable-id-stripping --enable-comment-stripping --shorten-ids --no-line-breaks --strip-xml-space -i "$src" -o "$tmp"
    and mv "$tmp" "$src"
end
