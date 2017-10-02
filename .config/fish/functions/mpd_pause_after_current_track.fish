function mpd_pause_after_current_track
    # src: https://bbs.archlinux.org/viewtopic.php?id=55884
    sleep (mpc | awk -F"[ /:]" '/playing/ {print 60*($8-$6)+$9-$7}')
    mpc pause
end
