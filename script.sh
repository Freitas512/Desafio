#!/bin/bash
USERNAME="admin"
HOSTS=""
SCRIPT="show run; exit"
CONTROLVAR=""

while  [ "$CONTROLVAR" != "end" ] ; do
	echo "THE DEFAULT USERNAME IS: admin"

	echo "WRITE \"end\" TO END THE PROGRAM"

	echo "WRITE HOST IP:"
	read hostip

	if [ "$hostip" != "end" ] 
	then 
		HOSTS="${HOSTS} $hostip"
	fi

	CONTROLVAR=${hostip}

done

echo ${HOSTS}

for HOSTNAME in ${HOSTS} ; do

        ssh -c aes256-cbc -l ${USERNAME} ${HOSTNAME} "${SCRIPT}" > conf.txt
        RS=$(grep -Rin "Hostname" conf.txt |cut -d " " -f 2| rev | cut -c 2- | rev )
        echo ${RS}
        touch ${RS}
        mv conf.txt ${RS}

done
git add .
git commit -m "New config files"
git push

