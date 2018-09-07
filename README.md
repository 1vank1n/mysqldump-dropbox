# Description

1. Create dump all databases of MySQL server.
2. Compress gzip (filename looks like `database.sql.gz`)
2. Upload to Dropbox via [Dropbox-Uploader](https://github.com/andreafabrizi/Dropbox-Uploader)
4. (Un)Remove local backups (configure via SAVE_LOCAL)

# Installation

    git clone https://github.com/1vank1n/mysqldump-dropbox.git

# Usage

    Two steps.

    *First*. Register your app in dropbox. For hint, just start `bash dropbox_uploader.sh`

    *Second*. Edit `VARS` section in `mysql2dropbox.sh`.

    MYSQL_USER=""
    MYSQL_PASS=""
    BACKUPS_DIR="./backups" -- folder for local backups
    REMOTE_FOLDER="example" -- folder for dropbox
    DROPBOX_UPLOADER="./dropbox_uploader.sh" -- path to dropbox_uploader.sh script
    DROPBOX_UPLOADER_CONFIG="./.dropbox_uploader" -- config of dropbox_uploader
    SAVE_LOCAL=false -- save/remove files in BACKUPS_DIR after they uploaded to Dropbox

# Crontab

    0 0 * * * cd /root/DIRECTORY_WITH_SCRIPTS; ./mysql2dropbox.sh &>> ./mysql2dropbox.log
