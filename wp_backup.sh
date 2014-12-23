#!/bin/bash
#
# A simple script to backup the wordpress database and www root
# The resulted tarball has to be fetched by someone
# Empty variables need to be filled 

date=$(date +%Y%m%d)
date_old=$(date --date=3-days-ago +%Y%m%d)
backupdir="~/backups"
sitename=""

db_name=""
db_user=""
db_pass=""

[ -d $backupdir ] || mkdir $backupdir

# Deleting old backups
[ -f $backupdir/$sitename-$date_old.tgz ] && rm -f $backupdir/$sitename-$date_old.tgz 

# Dumping mysql database
mysqldump -u$db_user -p$db_pass $db_name > /var/$db_name.sql

# Packing up the content along with db dump
tar cvzf $backupdir/$sitename-$date.tgz -C /var www $db_name.sql

# Removing the dump
rm -f /var/wordpress.sql
