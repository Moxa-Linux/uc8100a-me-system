#!/bin/sh
#History:
#	2016/01/21	For T2 test in factory
#	2017/12/18	Add TPM_FLAG for UC-8112-ME

flags=`fw_printenv mm_flags`
flags="${flags##*=}"

T2_FLAG=$((0x1 << 6))
T2_status=$(($flags & $T2_FLAG))

TPM_FLAG=`i2cdump -f -y -r 0x6a-0x6a 0 0x50 | grep 60 | awk '{print $2}'`

if [ "$T2_status" != "0" ]; then
#	echo "*** T2 burn-in flag is SET ***"
	fw_printenv biosver
	fw_printenv serialnumber
else
	echo "*** T2 burn-in flag is CLEAR ***"
	
	# Check TPM module
	echo $TPM_FLAG > /dev/shm/tpm_flag.txt
	systemctl stop tpm2-resourcemgr.service

	# Set UART mode
	mx-uart-ctl -p 0 -m 0
	mx-uart-ctl -p 1 -m 0

	# Kill background process
	sleep 15
	killall chk_signal

	# Start moxaburn
	[ -x /bin/moxaburn ] && /bin/moxaburn
fi
