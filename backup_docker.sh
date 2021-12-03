#!/bin/bash

docker ps |awk 'BEGIN {first = 1; last = 2 }
{for (i = first; i < last; i++) { if( $i == "CONTAINER" ) continue; 
else  printf("echo ");
for (j = last; j <= last; j++) {  if( $j == "ID" ) continue;
else { gsub(":","_",$j);  gsub("/","_",$j);  printf("%s tar is creating on external drive...\n", $j); printf("docker export %s |gzip > /media/pi/DriveCos/%s.tar.gz\n", $i, $j)}}}}' > execute_backup.sh

. execute_backup.sh
