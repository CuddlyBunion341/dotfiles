# Arch setup

## Step1: Partitions

### Selecting partitions

| Size  | Filesystem | Mount Point | Description |
|-------|------------|-------------|-------------|
| 4 GB  | Swap       | -           | Swap space  |
| 32 GB | ext4       | /           | Root        |
| 10 GB | ext4       | /backup     | Backup      |
| 1 GB  | FAT32      | /boot/efi   | Boot EFI    |

### Commands

```shell
fdisk -l / fdisk -x      # List partition tables for all devices
cfdisk /dev/nvme0n1      # Interactive partition table manipulator for /dev/nvme0n1

mkfs.ext4 /dev/<root_partition_name>
mkfs.ext4 /dev/<backup_partition_name>
mkfs.fat -F32 /dev/<efi_partition_name>
mkswap /dev/<swap_partition_name>
swapon /dev/<swap_partition_name>
```

### Network:

* https://www.reddit.com/r/archlinux/comments/ygi4y6/how_do_i_connect_to_the_internet_without_dhcp/

### Sources

* https://arch.d3sox.me/installation/configure-system

### Learnings

When selecting bootable medium, select UEFI usb disk instead of BIOS when installing Arch on a UEFI system.


## Step2: Base Arch Installation

### Commands

Setup network

```
wctl
# Run these commands in interactive mode
station list
station wlan0 scan
station wlan0 connect <SSID>
station wlan0 show
# Exit interactive mode
```

Install base system

```shell
pacman -Sy
archinstall
# Partition configuration -> Manual, verify mount points
# Create user (username: dani), set password, set root password
# Set profile to desktop -> hyprland -> sddm
```
