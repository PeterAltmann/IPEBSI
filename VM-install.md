# VM install instructions for the EBSI full stack node

These instructions are for setting up a replica of the full stack EBSI node. It will be updated as information becomes available.

## VM setup using Ubuntu 18.04 LTS

* Parted docs: https://www.gnu.org/software/parted/manual/html_chapter/parted_2.html
* Fstab docs: https://help.ubuntu.com/community/Fstab


Prepare the system:
```bash
$ sudo su                         # switch to super user
$ apt update && apt upgrade -y    # update and upgrade system
```

Setup the disks as follows:
```bash
$ parted /dev/vdb -s mklabel gpt \  mkpart primary 0% 100%
$ lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
...
vdb     252:16   0 1000G  0 disk
└─vdb1  252:17   0 1000G  0 part /mnt/disk1
$ mkfs.ext4 /dev/vdb1    # set filesystem
$ mkdir -p /mnt/disk1    # folders for mountpoint
```

Setup automatic mount on startup:
```bash
$ cp /etc/fstab /etc/fstab.old  # backup fstab
$ lsblk -o NAME,UUID
...
vdb
└─vdb1  <number>
$ echo "UUID=<number> /mnt/disk1 ext4 defaults 0 0" >> /etc/fstab
```

Mount the disks and check (may require reboot to show up properly):
```bash
$ mount -a
$ df -h | grep mnt
/dev/vdb1       984G   77M  934G   1% /mnt/disk1
```

Prepare a swap file (just in case)
```bash
$ fallocate -l 16GiB /swapfile  # allocate swapfile size
$ chmod 600 /swapfile           # https://chmodcommand.com/chmod-600/
$ mkswap /swapfile              # set up swap area on the file
Setting up swapspace version 1, size = 16 GiB (17179865088 bytes)
no label, UUID=fa947494-4e6c-43a0-8264-fcd1449c8517
$ swapon /swapfile              # activate swap file
$ echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
```

## Check system information 
```bash
$ free -h
              total        used        free      shared  buff/cache   available
Mem:            15G        179M         14G        744K        1.3G         15G
Swap:           15G          0B         15G
$ lshw -short -class processor -class memory -class volume
H/W path      Device      Class          Description
====================================================
/0/0                      memory         96KiB BIOS
/0/400                    processor      Intel Core Processor (Haswell, no TSX,
/0/401                    processor      Intel Core Processor (Haswell, no TSX,
/0/402                    processor      Intel Core Processor (Haswell, no TSX,
/0/403                    processor      Intel Core Processor (Haswell, no TSX,
/0/404                    processor      Intel Core Processor (Haswell, no TSX,
/0/405                    processor      Intel Core Processor (Haswell, no TSX,
/0/406                    processor      Intel Core Processor (Haswell, no TSX,
/0/407                    processor      Intel Core Processor (Haswell, no TSX,
/0/1000                   memory         16GiB System Memory
/0/1000/0                 memory         16GiB DIMM RAM
/0/100/5/0/1  /dev/vda1   volume         31GiB EXT4 volume
/0/100/5/0/e  /dev/vda14  volume         4095KiB BIOS Boot partition
/0/100/5/0/f  /dev/vda15  volume         105MiB Windows FAT volume
/0/100/6/0/1  /dev/vdb1   volume         999GiB EXT4 volume
```

## Setup VMware on remote VM

* all steps assume `sudo su`

Optional: install Xfce on the server for remote desktop use
```bash
$ apt install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils   # write startx in Terminal using remote desktop
$ startx    # start Xfce desktop
```

Download and install VMware Workstation Player
```bash
$ apt install build-essential linux-headers-generic # build dependencies
$ wget -P ~/Downloads/ --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getplayer-linux
$ chmod +x ~/Downloads/getplayer-linux  # make executable
$ ~/Downloads/getplayer-linux         # start install
Extracting VMware Installer...done.
.
.
.
Installation was successful.
$ vmplayer # to start
```

Download the EBSI node image
```bash
$ wget -P /mnt/disk1 https://infra.ebsi.xyz/get/vmware/EBSI_v1.1.ova --user=<user> --ask-password
Password for user ‘<user>’: # enter password here
```

Setup the hostname
```bash
$ hostnamectl set-hostname <newhostname>
$ hostname # check if it worked
```

## SSH config for RISE ICE

* See https://ecc.north.sics.se/about for details on environment
* Get your key file, e.g., \*.pem
* Assumes that you have VM installed

```bash
$ cd ~/.ssh     # go to your ssh directory. If does not exist, mkdir it
$ touch config  # create the config file
$ nano config   # edit according to need
  GNU nano 2.0.6               File: config
Host ebsi-app
  Port <port#>

Host ebsi-besu
	Port <port#>

Host ebsi-fabric
	Port <port#>

Host *
	HostName <IP>  # RISE ICE has same IP for all VMs
	User <user>
	IdentityFile ~/.ssh/private-ssh-key.pem
```
