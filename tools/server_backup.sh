#!/bin/bash
cd /home/backup/
dateDIR=`date +"%Y-%m-%d"`
mkdir -p /home/backup/$dateDIR

echo -ne "Dump mysql..."

docker exec -it lnmp_mysql_1 mysqldump -uroot -p123456 table > /home/backup/$dateDIR/table.sql

tar zcvf /home/backup/$dateDIR/table.sql.tar.gz /home/backup/$dateDIR/table.sql

rm -rf /home/backup/$dateDIR/table.sql

echo -ne "Backup web files..."
#tar zcvf /home/backup/$dateDIR/project.gz /www/project

rm -rf /home/backup/$(date -d -7day +%Y-%m-%d)

# https://github.com/andreafabrizi/Dropbox-Uploader/
/root/dropbox_uploader.sh upload /home/backup/$dateDIR /project
/root/dropbox_uploader.sh delete /project/$(date -d -7day +%Y-%m-%d) 

#yum install crontabs 定时 crontab -e
# 0 6 * * * /home/server_backup.sh