#!/bin/bash
localectl set-x11-keymap us,ge
localectl set-locale LC_NUMERIC=ka_GE.UTF-8 LC_TIME=ka_GE.UTF-8 LC_MONETARY=ka_GE.UTF-8 LC_PAPER=ka_GE.UTF-8 LC_MEASUREMENT=ka_GE.UTF-8
systemctl disable barch