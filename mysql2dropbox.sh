#!/usr/bin/env bash
#
# mysql2dropbox
#
# Copyright (C) 2015 Ivan Lukyanets <ivan@il-studio.ru>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#

# VARS
MYSQL_USER=""
MYSQL_PASS=""
BACKUPS_DIR="./backups"
REMOTE_FOLDER="example"
DROPBOX_UPLOADER="./dropbox_uploader.sh"
DROPBOX_UPLOADER_CONFIG="./.dropbox_uploader"
SAVE_LOCAL=false

# Timestamp
echo $(date)

# Create backups temp dir
mkdir $BACKUPS_DIR

# Dump, gzip, databases
for dbname in `echo show databases | mysql -u $MYSQL_USER -p$MYSQL_PASS`; do
    echo "Dump $dbname..."
    mysqldump -u $MYSQL_USER -p$MYSQL_PASS $dbname | gzip > $BACKUPS_DIR/$dbname.sql.gz
done;

# Upload with Dropbox-uploader https://github.com/andreafabrizi/Dropbox-Uploader
$DROPBOX_UPLOADER -f $DROPBOX_UPLOADER_CONFIG mkdir $REMOTE_FOLDER
$DROPBOX_UPLOADER -f $DROPBOX_UPLOADER_CONFIG upload $BACKUPS_DIR/* /$REMOTE_FOLDER/

if $SAVE_LOCAL; then
    echo "Local version SAVED."
else
    rm -rf "$BACKUPS_DIR"
fi

echo "Upload to Dropbox completed."
