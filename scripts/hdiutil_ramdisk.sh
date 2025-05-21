#NUMSECTORS=2097152       # a sector is 512 bytes
NUMSECTORS=4194304       # a sector is 512 bytes
mydev=`hdiutil attach -nomount ram://$NUMSECTORS`
newfs_hfs $mydev
mkdir ~/ramdisk
mount -t hfs $mydev ~/ramdisk

