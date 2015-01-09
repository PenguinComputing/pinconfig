#!/bin/bash
#
#  Load managers for each GPIO and device we need
#

# GPIO we need
for dtbo in \
      gpio-P8.{33..36} \
      gpio-P8.{39..42} \
      gpio-P8.{43..46} \
      gpio-P8.11 gpio-P8.12 gpio-P8.16 \
      gpio-P9.27 \
      gpio-P9.{11,13} \
      BB-UART5RTSCTS \
      BB-I2C1A1 \
      BB-SPIDEV0 \
      BB-SPIDEV1B1
   do
   if ! grep -q ,${dtbo}\$ /sys/devices/bone_capemgr.*/slots ; then
      echo $dtbo > /sys/devices/bone_capemgr.*/slots
      sleep .3
   fi
done

# Configure GPIO as outputs and drive low
for gpio in 30 31 {44..46} {70..72} 115
   do
   echo $gpio > /sys/class/gpio/export
   while [[ ! -e /sys/class/gpio/gpio$gpio ]]; do
      sleep .1 
   done
   echo out > /sys/class/gpio/gpio$gpio/direction
   echo 0 > /sys/class/gpio/gpio$gpio/value
done

# Disable all i2c busses
# EXP1_I2C % 9516_EN1 = P8-42 = LCD_DATA5 = GPIO2_11 = gpio75
# EXP2_I2C % 9516_EN2 = P8-41 = LCD_DATA4 = GPIO2_10 = gpio74
# EXP3_I2C % 9516_EN3 = P8-40 = LCD_DATA7 = GPIO2_13 = gpio77
# TCC_I2C  % 9516_EN4 = P8-39 = LCD_DATA6 = GPIO2_12 = gpio76
for gpio in {74..77}
   do
   echo $gpio > /sys/class/gpio/export
   while [[ ! -e /sys/class/gpio/gpio$gpio ]]; do
      sleep .1 
   done
   echo out > /sys/class/gpio/gpio$gpio/direction
   echo 0 > /sys/class/gpio/gpio$gpio/value
done

# But change 76 (i2c enable for TCC) to ENABLE
echo 1 > /sys/class/gpio/gpio76/value
# And attach eeprom driver for temperature cape @ 0x50
echo 24c256 0x50 > /sys/bus/i2c/devices/i2c-1/new_device

for gpio in 8 9 73 80 81 ; do
   echo $gpio > /sys/class/gpio/export
   while [[ ! -e /sys/class/gpio/gpio$gpio ]]; do
      sleep .1
   done
   echo in > /sys/class/gpio/gpio$gpio/direction
done
