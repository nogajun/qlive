BOOTOPTION_LIVE = quit locale=ja_JP.UTF-8 klayout=jp kmodel=acpi vga=788 video=vesa:ywrap,mtrr splash persistent
#BOOTOPTION_INSTALLER = -- quiet video=vesa:ywrap,mtrr vga=788

all: config build

config: clean
	lh config \
	 	--binary-images usb-hdd \
		--bootappend-live "$(BOOTOPTION_LIVE)" \
		--distribution squeeze \
		--linux-flavours 686 \
		--linux-packages "linux-image-2.6 aufs-modules-2.6 kqemu-modules-2.6.30-2" \
		--packages-lists "standard-x11 video" \
		--packages "qemu qemu-kvm kqemu-common vde2 alsa-oss oss-compat libasound2-plugins usplash insserv prelink" \
		--apt-recommends disabled
build: 
	sudo lh build 

clean:
	sudo lh clean

distclean: clean
	sudo lh clean --purge
	sudo rm -f *.iso *.img *.list *.packages *.buildlog *.md5sum

