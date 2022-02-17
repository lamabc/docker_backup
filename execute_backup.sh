
echo "Deleting old files to free disk /dev/root/..."
sudo find /home/pi/containers/ -type f -mtime +5 -delete
echo "Deleting old files to free disk /dev/sdb1..."
sudo find /media/pi/DriveCos/IOT_boot_camp/save/ -type f -mtime +5 -delete
echo iotstack_zigbee2mqtt_latest tar is creating on local drive...
docker export 2ecad1f54ee7 |gzip > /home/pi/containers/iotstack_zigbee2mqtt_latest_Thu_17_Feb_2022_04_34_43_PM_CET.tar.gz
echo iotstack_mosquitto_latest tar is creating on local drive...
docker export b3807defaeeb |gzip > /home/pi/containers/iotstack_mosquitto_latest_Thu_17_Feb_2022_04_34_43_PM_CET.tar.gz
echo grafana__grafana tar is creating on local drive...
docker export 58691a824bfd |gzip > /home/pi/containers/grafana__grafana_Thu_17_Feb_2022_04_34_43_PM_CET.tar.gz
echo portainer__portainer-ce tar is creating on local drive...
docker export a172110877d4 |gzip > /home/pi/containers/portainer__portainer-ce_Thu_17_Feb_2022_04_34_43_PM_CET.tar.gz
echo iotstack_nodered tar is creating on local drive...
docker export bbcf21a4032f |gzip > /home/pi/containers/iotstack_nodered_Thu_17_Feb_2022_04_34_43_PM_CET.tar.gz
echo influxdb_1.8 tar is creating on local drive...
docker export 719cda2a5f3e |gzip > /home/pi/containers/influxdb_1.8_Thu_17_Feb_2022_04_34_43_PM_CET.tar.gz
echo ">>>>>>>>>>>>>> ARCHAVING IOTStack folder................\n"
sudo tar -czvf IOTstack_Thu_17_Feb_2022_04_34_43_PM_CET.tar.gz /home/pi/IOTstack/
mv IOTstack_Thu_17_Feb_2022_04_34_43_PM_CET.tar.gz /home/pi/containers/ 
cp /etc/haproxy/haproxy.cfg /home/pi/containers/haproxy_Thu_17_Feb_2022_04_34_43_PM_CET.cfg
echo "Copy containers files in /media/pi/DriveCos/IOT_boot_camp/save/..."
sudo cp -r  /home/pi/containers/* /media/pi/DriveCos/IOT_boot_camp/save/ 
cp /home/pi/containers/haproxy_Thu_17_Feb_2022_04_34_43_PM_CET.cfg /media/pi/DriveCos/IOT_boot_camp/save/ 
