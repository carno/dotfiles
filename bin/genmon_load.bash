#!/usr/bin/env bash

echo "<txt>$(cut -d ' ' -f 1-3 /proc/loadavg)</txt>"
echo "<txtclick>xfce4-terminal -x htop</txtclick>"
echo "<tool>load avg</tool>"
