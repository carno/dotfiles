#!/usr/bin/env bash

temps="$(sensors -A)"
echo "<txt>$(echo "${temps}" | awk '/Core 0/{print $3}') $(echo "${temps}" | awk '/Core 1/{print $3}') $(echo "${temps}" | awk '/fan1/{print $2}')rpm</txt>"
echo "<tool>Core 0 temp; Core 1 temp; fan speed</tool>"
