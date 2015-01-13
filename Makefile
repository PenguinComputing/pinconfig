# Makefile for Power Insight Device tree

DSRCS = $(wildcard *.dts)
dt: $(DSRCS:.dts=.dtbo)

.PHONY: clean install

install: dt
	cp $(DSRCS:.dts=.dtbo)/lib/firmware
	echo Manually run configure_pins.sh or add to /etc/rc.local

clean:
	$(RM) *.dtbo

# use device tree compiler (dtc) to build dtbo files as fragments
%.dtbo: %.dts
	dtc -O dtb -o $@ -b 0 -@ -I dts $<
