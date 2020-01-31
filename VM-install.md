# VM install instructions for the EBSI full stack node

These instructions are for setting up a replica of the full stack EBSI node. It will be updated as information becomes available.

## VM setup using Ubuntu 18.04 LTS

Prepare the system
```bash
$ sudo su                         # switch to super user
$ apt update && apt upgrade -y    # update and upgrade system
```
Setup the disks as follows:

```bash
$ parted /dev/vdb -s mklabel gpt \  mkpart primary 0% 100GiB \ mkpart primary 100GiB 400GiB
$ lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
...
vdb     252:16   0 1000G  0 disk
├─vdb1  252:17   0  100G  0 part
└─vdb2  252:18   0  300G  0 part
$ mkfs.ext4 /dev/vdb1 && mkfs.ext4 /dev/vdb2
$ mkdir /mnt/disk1 && mkdir /mnt/disk2         # folders for mountpoint
```
Setup the automount

```bash
$ cp /etc/fstab /etc/fstab.old  # optional backup of fstab
$ lsblk -o NAME,UUID
...
vdb
├─vdb1  3ed7beb9-64a5-408c-9231-62d3fdccaf73
└─vdb2  b19c6b4a-3ab0-4499-9188-8a152d0adc33
$ echo "UUID=3ed7beb9-64a5-408c-9231-62d3fdccaf73 /mnt/disk1 ext4 defaults 0 0" >> /etc/fstab
$ echo "UUID=b19c6b4a-3ab0-4499-9188-8a152d0adc33 /mnt/disk1 ext4 defaults 0 0" >> /etc/fstab
```
Mount the disks and check
```bash
$ mount -a && df -h -x tmpfs | grep mnt
/dev/vdb1        98G   61M   93G   1% /mnt/disk1
/dev/vdb2       295G   65M  280G   1% /mnt/disk2
```
