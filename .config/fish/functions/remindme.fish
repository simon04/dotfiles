function remindme --description 'a simple reminder' --argument-names time text
    sleep $time
    zenity --info --text $text
end
