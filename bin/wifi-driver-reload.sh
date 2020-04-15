#!/bin/sh
# Bug:
# https://bugzilla.kernel.org/show_bug.cgi?id=201853
# 
# Check:
# lspci
# dmesg
# 
# Workaround:
sudo modprobe -r brcmfmac; sudo modprobe brcmfmac
