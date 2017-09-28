function qr --description 'Displays the arguments as QR code'
    qrencode -s7 -o - $argv | display
end
