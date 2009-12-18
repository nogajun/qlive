#!/bin/bash

# check qemu.conf file
if [ -e /live/image/qemu/qemu.conf ]
then
        . /live/image/qemu/qemu.conf
else
        echo "Not configured, define /live/image/qemu/qemu.conf."
        exit 1
fi

# set blank screen
/usr/bin/xsetroot -solid black &

# set virtual machine
KQEMUCHECK=$(lsmod | grep kqemu)
case ${VM} in
	kvm)
	  [ -n "${KQEMUCHECK}" ] && sudo sh -c "/sbin/rmmod kqemu"
	  sudo sh -c "/etc/init.d/qemu-kvm start"
	  AOSS=""
	  VM=/usr/bin/kvm
	;;
	kqemu)
	  sudo sh -c "/etc/init.d/qemu-kvm stop"
	  [ -z "${KQEMUCHECK}" ] && sudo sh -c "/sbin/modprobe kqemu"
	  AOSS="/usr/bin/aoss"
	  VMOPTIONS="${VMOPTIONS} -kernel-kqemu"
	  VM=/usr/bin/qemu
	;;
	qemu)
	  sudo sh -c "/etc/init.d/qemu-kvm stop"
	  [ -n "${KQEMUCHECK}" ] && sudo sh -c "/sbin/rmmod kqemu"
	  AOSS="/usr/bin/aoss"
	  VMOPTIONS="${VMOPTIONS}"
	  VM=/usr/bin/qemu
	;;
	*)
      echo "Not configured Virtual Machine, define /live/image/qemu/qemu.conf."
      exit 1
	;;
esac

exec ${AOSS} ${VM} -hda ${VMIMAGE} ${VMOPTIONS} -full-screen & QEMUPID="${!}"
wait ${QEMUPID}
