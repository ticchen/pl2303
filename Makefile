# SPDX-License-Identifier: GPL-2.0
#
# Makefile for the USB serial device drivers.
#

# Object file lists.

obj-m			+= pl2303.o

########################################
# DKMS
########################################
-include dkms.conf

install: install_soft

install_soft:
	make dkms_add_with_link
	make dkms_install_driver

install_hard:
	make dkms_add_with_files
	make dkms_install_driver

uninstall:
	make dkms_remove

dkms_add_with_link:
	sudo ln -sT $(PWD) /usr/src/$(PACKAGE_NAME)-$(PACKAGE_VERSION)
	sudo dkms add -m $(PACKAGE_NAME) -v $(PACKAGE_VERSION)

dkms_add_with_files:
	sudo mkdir /usr/src/$(PACKAGE_NAME)-$(PACKAGE_VERSION)
	sudo cp $(PWD)/* /usr/src/$(PACKAGE_NAME)-$(PACKAGE_VERSION)/
	sudo dkms add -m $(PACKAGE_NAME) -v $(PACKAGE_VERSION)

dkms_remove:
	sudo dkms remove -m $(PACKAGE_NAME) -v $(PACKAGE_VERSION) --all
	sudo rm -rf /usr/src/$(PACKAGE_NAME)-$(PACKAGE_VERSION)

dkms_install_driver:
	#sudo dkms build -m pl2303/1.0
	sudo dkms install -m $(PACKAGE_NAME) -v $(PACKAGE_VERSION)

dkms_uninstall_driver:
	sudo dkms uninstall -m $(PACKAGE_NAME) -v $(PACKAGE_VERSION)

dkms_status:
	dkms status -m $(PACKAGE_NAME) -v $(PACKAGE_VERSION)

########################################
# module build
########################################
build:
	$(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	$(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
