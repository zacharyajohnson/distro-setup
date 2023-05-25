#!/bin/sh

sudo pacman -S lm_sensors hddtemp

sudo sensors-detect

sudo pacman -S psensor
