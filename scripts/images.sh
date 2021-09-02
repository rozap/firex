#!/bin/bash
mkdir -p images
arch=`uname -m`
dest_kernel="vmlinux.bin"
dest_rootfs="rootfs.ext4"
image_bucket_url="https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/$arch"

kernel="${image_bucket_url}/kernels/vmlinux.bin"
rootfs="${image_bucket_url}/rootfs/bionic.rootfs.ext4"

curl -L -o images/vmlinux.bin $kernel
curl -L -o images/rootfs.ext4 $rootfs
