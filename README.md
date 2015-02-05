# pinconfig
PowerInsight pin configuration files and scripts

Copyright (C) Penguin Computing.  All rights reserved.


WHAT IS THIS?
-----

These files are used to configure a beaglebone for PowerInsight when using
a kernel with devicetree support and the latest TI support for the on-chip
resources.

Thanks to "nomel" and github for the gpio-xxx.dts files.  You can find the
original script to generate these files in github here:
https://github.com/nomel/beaglebone.git

INSTALL
-----

The makefile will convert the .dts into .dtbo files which need to be copied
to /lib/firmware.  "make install" will copy the files there.

You must MANUALLY configure the system to run the "configure_pins.sh" script
either at startup (we recommend /etc/rc.local) or before running powerInsight.

You may also want to make sure that the time is set correctly (as the
BeagleBone does not have a realtime clock) using ntpdate or other method of
your choice.
