BOOTOPTION_LIVE = quiet locale=ja_JP.UTF-8 keyb=jp kmodel=jp106 vga=788 persistent
BOOTOPTION_INSTALLER = -- quiet video=vesa:ywrap,mtrr vga=788

all: config build

config: clean
	lh_config \
	 	--binary-images usb-hdd \
		--bootappend-live "$(BOOTOPTION_LIVE)" \
		--distribution sid \
		--linux-flavours 686 \
		--linux-packages "linux-image-2.6 aufs-modules-2.6.30-1" \
		--packages-lists "standard-x11 video" \
		--packages "qemu dash vde2 alsa-oss oss-compat libasound2-plugins insserv prelink usplash" \
		--apt-recommends disabled
build: 
	sudo lh_build 

clean:
	sudo lh_clean

distclean: clean
	sudo lh_clean --purge
	sudo rm -f *.iso *.img *.list *.packages *.buildlog *.md5sum

