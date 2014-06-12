#!/bin/bash

killall -9 puredata
killall -9 LSmidi5

echo "starting pd..."
puredata -alsamidi -mididev 5,1 ~/code/linzerschnitte-utils/pd/miditest.pd < /dev/null > /dev/null 2>&1 &

sleep 3

echo "starting lsmidi..."
cd ~/code/linzerschnitte-server && ./run.pi.sh < /dev/null > /dev/null 2>&1 &

sleep 2

echo "connecting alsa sequencer..."
LPDC=`aconnect -i | grep LPD8 | grep client | grep -Po "[0-9]*(?=:)"`
LPDOUTP=`aconnect -i | grep LPD8 | grep -E "^ " | grep -Po "[0-9] (?=\')"`

PDC=`aconnect -i | grep Pure | grep client | grep -Po "[0-9]*(?=:)"`
PDINP=`aconnect -o | grep Pure |  grep -E "^ " | grep -Po "[0-9] (?=\')" | head -1`
PDOUTP=`aconnect -i | grep Pure |  grep -E "^ " | grep -Po "[0-9] (?=\')" | head -1`

LSC=`aconnect -o | grep Linzer | grep client | grep -Po "[0-9]*(?=:)"`
LSINP=`aconnect -o | grep Linzer |  grep -E "^ " | grep -Po "[0-9] (?=\')" | head -1`

A1=$LPDC:$LPDOUTP
A2=$PDC:$PDINP
B1=$PDC:$PDOUTP
B2=$LSC:$LSINP

echo $A1 $A2 $B1 $B2

aconnect -x
aconnect $A1 $A2
aconnect $B1 $B2
