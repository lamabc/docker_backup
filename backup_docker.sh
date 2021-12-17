#!/bin/bash
DIR_EX_DRIVE="/home/pi/DriveCos"

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
			printf("docker export %s |gzip > /home/pi/containers/%s.tar.gz\n", $i, $j);
		     }
              }
  }
}' > execute_backup.sh

echo "echo \">>>>>>>>>>>>>> ARCHAVING IOTStack folder................\n\"" >> execute_backup.sh
echo "tar -czvf IOTstack.tar.gz /home/pi/IOTstack/" >>  execute_backup.sh


if [ -d "$DIR_EX_DRIVE" ]; then
  ### Take action if $DIR exists ###
  echo "echo \"Copy containers files in ${DIR}...\n\"" >> execute_backup.sh
  echo "echo \"sudo cp -r  /home/pi/containers/* /home/pi/DriveCos\n\"" >> execute_backup.sh
  echo "echo \"sudo cp -r  /home/pi/work/backup/docker_backup/IOTstack.tar.gz /home/pi/DriveCos\n\"" >> execute_backup.sh  
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "echo \"Error: ${DIR_EX_DRIVE} not found. Can not continue.\n\"" >> execute_backup.sh
fi

. execute_backup.sh
