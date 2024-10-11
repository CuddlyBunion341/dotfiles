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
```

### Network:

* https://www.reddit.com/r/archlinux/comments/ygi4y6/how_do_i_connect_to_the_internet_without_dhcp/

### Sources

* https://arch.d3sox.me/installation/configure-system

### Learnings

When selecting bootable medium, select UEFI usb disk instead of BIOS when installing Arch on a UEFI system.

