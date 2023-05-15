#!/bin/sh

$install_command lm-sensors hddtemp

sudo sensors-detect

$install_command psensor
