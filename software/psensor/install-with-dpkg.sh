#!/bin/sh

sudo apt-get install -y lm-sensors hddtemp

sudo sensors-detect

sudo apt-get install -y psensor
