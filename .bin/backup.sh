#!/bin/sh
set -e
backupDev=/dev/sdf1
backupMount=/media/Backup

case $1 in
  '')
    echo "Usage: $0 [up|down|/dir/]"
    ;;
  up)
    sudo cryptsetup luksOpen $backupDev Backup
    sudo mount /dev/mapper/Backup $backupMount
    ;;
  down)
    sudo umount $backupMount
    sudo cryptsetup luksClose Backup
    ;;
  *)
    dir=$1
    dir_base=$(basename "$dir")
    [[ -d ../$dir ]] || echo "../$dir does not exist!"
    [[ -d ../$dir ]] || exit
    new=$dir_base-$(date -I)
    existing=$(basename $(ls -d $backupMount/$dir_base-????-??-?? | tail -n1))
    echo "Backing up $dir as $new using delta wrt. $existing"
    [[ -d $new ]] || btrfs subvolume snapshot -r ../$dir $new
    [[ -d $backupMount/$new ]] || (sudo btrfs send -v -p $existing $new | sudo btrfs receive $backupMount/)
    ls -ld $backupMount/$dir_base-*
    ;;
esac


