#!/bin/bash
ACTUALSIZE=$(df --output=target,avail|awk '{print $1 $2}'|grep -m 1 "^/[0-9]*$"|sed "s/\///")
#echo $ACTUALSIZE
SIZE=310163640
if [ ${ACTUALSIZE} -lt ${SIZE} ]; then
   echo $SIZE 
fi
    
