#!/bin/sh

printf '%s' "Enter hostname: "
read -r VM_HOSTNAME

printf '%s' "Enter username: "
read -r VM_USERNAME

printf '%s' "Enter password: "
read -r VM_PASSWORD

virsh_network="$(virsh net-list --name | head -n 1)"
if [ -z "$virsh_network" ]; then
    echo "Could not determine default network!"
    exit 2
fi

cp preseed.cfg.template preseed.cfg
sed -i "s/HOSTNAME/$VM_HOSTNAME/" preseed.cfg
sed -i "s/USERNAME/$VM_USERNAME/" preseed.cfg
sed -i "s/PASSWORD/$VM_PASSWORD/" preseed.cfg

virt-install \
    --connect "qemu:///system" \
    --name "$VM_HOSTNAME" \
    --memory 2048 \
    --vcpus 2 \
    --disk size=10 \
    --network network="$virsh_network" \
    --location "https://mirror.netzwerge.de/debian/dists/stable/main/installer-amd64/" \
    --osinfo detect=on,name=debian13 \
    --initrd-inject="./preseed.cfg" \
    --extra-args="auto"
