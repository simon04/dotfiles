function httpd_php --description "Launches PHP's built-in web server"
    if count $argv >/dev/null
        php -S $argv
    else
        php -S localhost:8000
    end
end