#!/bin/bash
DIR_EX_DRIVE="/media/pi/DriveCos/IOT_boot_camp/save/"
MOUNT_POINT_BACKUP_DRIVE="/media/pi/DriveCos"
CONT_FOLDER="/home/pi/containers/"
DATE=$(date)
FILENAME="execute_backup.sh"
DATE=$(echo $DATE |sed -r 's/[ :]+/_/g')
ACTUALSIZE=$(df --output=target,avail|awk '{print $1 $2}'|grep -m 1 "^/[0-9]*$"|sed "s/\///")
ACTUAL_SIZE_BACKUP_DRIVE=$(df --output=target,avail|awk '{print $1 $2}'|grep -m 1 "^$MOUNT_POINT_BACKUP_DRIVE[0-9]*$"|sed 's,'"$MOUNT_POINT_BACKUP_DRIVE"',,')
NOT_LESS_THEN_SIZE_TO_PERFORM_DELETE=110163640
SIZE_OF_DISK_TO_SKIP_BACKUP=5163640
NUMBER_OF_DAYS=30

echo "" > execute_backup.sh

if [ ${ACTUALSIZE} -lt ${SIZE_OF_DISK_TO_SKIP_BACKUP} ]; then
    echo "echo \"Not enough space to run backup on /dev/root/...\"" >> execute_backup.sh 
    exit
fi


if [ ${ACTUALSIZE} -lt ${NOT_LESS_THEN_SIZE_TO_PERFORM_DELETE} ]; then
    echo "echo \"Deleting old files to free disk /dev/root/...\"" >> execute_backup.sh
    echo "sudo find ${CONT_FOLDER} -type f -mtime +${NUMBER_OF_DAYS} -delete" >> execute_backup.sh
fi

if [ ${ACTUAL_SIZE_BACKUP_DRIVE} -lt ${NOT_LESS_THEN_SIZE_TO_PERFORM_DELETE} ]; then
    echo "echo \"Deleting old files to free disk /dev/sdb1...\"" >> execute_backup.sh
    echo "sudo find ${DIR_EX_DRIVE} -type f -mtime +${NUMBER_OF_DAYS} -delete" >> execute_backup.sh
fi



docker ps |awk 'BEGIN {first = 1; last = 2 }
{for (i = first; i < last; i++) {
	if( $i == "CONTAINER" ) continue;
	else  printf("echo ");
	for (j = last; j <= last; j++) {
		if( $j == "ID" ) continue;
		else {
	 		gsub(":","_",$j);
			gsub("/","__",$j); 
			printf("%s tar is creating on local drive...\n", $j); 
			printf("docker export %s |gzip > XXX%s.tar.gz\n", $i, $j);
		     }
              }
  }
}' >>  $FILENAME
sed -i 's,'"XXX"','"$CONT_FOLDER"',' $FILENAME
sed -i "s/.tar.gz/_${DATE}.tar.gz/" $FILENAME
echo "echo \">>>>>>>>>>>>>> ARCHAVING IOTStack folder................\n\"" >> execute_backup.sh
echo "sudo tar -czvf IOTstack_${DATE}.tar.gz /home/pi/IOTstack/" >>  execute_backup.sh
echo "echo \"MOVING IOTStack folder backup to containers folder...\n\"" >> execute_backup.sh
echo "mv IOTstack_${DATE}.tar.gz ${CONT_FOLDER} " >> execute_backup.sh
echo "echo \"Copying haproxy file to backup...\n\"" >> execute_backup.sh
echo "cp /etc/haproxy/haproxy.cfg ${CONT_FOLDER}haproxy_${DATE}.cfg" >> execute_backup.sh


if [ -d "$DIR_EX_DRIVE" ]; then
  ### Take action if $DIR exists ###
  echo "echo \"Copy containers files in ${DIR_EX_DRIVE}...\"" >> execute_backup.sh
  echo "cd ${CONT_FOLDER}"  >> execute_backup.sh
  echo "sudo ls -haltr|egrep ${DATE}.*|awk {'print \$9'}|xargs cp -t ${DIR_EX_DRIVE} " >> execute_backup.sh 
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "echo \"Error: ${DIR_EX_DRIVE} not found. Can not continue.\"" >> execute_backup.sh
fi

. execute_backup.sh
