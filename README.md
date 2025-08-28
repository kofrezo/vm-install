# vm-install.sh

Might be useful for you if you want to quickly setup Debian VMs for testing.

Minimal (POSIX) shell script to setup a Debian Trixie VM using virt-install.

Requires a working QEMU/libvirt setup as well as virt-install.

Running `vm-install.sh` will ask you for a hostname, username and password
for the VM. It will use the first network from `virsh net-list --name`.

