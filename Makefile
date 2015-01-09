# Makefile for Power Insight Device tree

DSRCS = $(glob *.dts)
dt: $(DSRCS:.dts=.dtbo)

.PHONY: clean install

install: dt
	$(CP) *.dtbo /lib/firmware
	$(ECHO) Manually run configure_pins.sh or add to /etc/rc.local

clean:
	$(RM) *.dtbo

# use device tree compiler (dtc) to build dtbo files as fragments
%.dtbo: %.dts
	dtc -O dtb -o $@ -b 0 -@ -I dts $<
