function remindme --description 'a simple reminder' --argument time text
    sleep $time
    zenity --info --text $text
end
