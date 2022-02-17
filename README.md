# docker_backup
The script is executed at every startup of the system
backing up docker containers/images
backing up also IOTstack folder

1.base on awk first we extract the id of the images  
2.we create a list of command in an separate file
3.at the end that file is executed 

Note:
1. The files names will be created with the current date in /home/pi/containers folder
2. The created files will be copy from containers folder /dev/root into /dev/sda1 backup folder
3. If there is less then 5 GB on main disk at startup we skip the backup
4. If there is less then 10 GB at startup on /dev/root and/or /dev/sda1 the old files less then 30 days will be deleted
