#!/bin/sh

rtc=$1

if [ -f /etc/default/sleepi-utils ] ; then
    . /etc/default/sleepi-utils
fi

if [ $rtc != $RTC_DEVICE ] ; then
    exit 0
fi

if [ -f /etc/init.d/sleepi-utils ] ; then
    /etc/init.d/sleepi-utils start
fi
