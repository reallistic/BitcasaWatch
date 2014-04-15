#!/bin/sh

echo "installing curl"
apt-get --yes install curl
echo "changing folder"
cd "/root"
if [ ! -d "plexwatch/" ]; then
    echo "Error cannot find plexwatch folder"
    return 0
fi

cd plexwatch
echo "Copying init files"
cp -f init/* /etc/init.d/

echo "Creating plex watch folder"
mkdir -p /var/lib/plexmediaserver/watch

echo "copying watch scripts"
cp -f watch/bitcasa-watch /var/lib/plexmediaserver/Bitcasa/
cp -f watch/plexmediaserver-watch /var/lib/plexmediaserver/watch

echo "changing permissions"
chown plex:nogroup /var/lib/plexmediaserver/Bitcasa/bitcasa-watch
chown -hR plex:nogroup /var/lib/plexmediaserver/watch

echo "Running on boot"
update-rc.d plexmediaserver-watch defaults
update-rc.d bitcasa-watch defaults

echo "starting scripts"
/etc/init.d/bitcasa-watch stop
/etc/init.d/bitcasa-watch start
/etc/init.d/plexmediaserver-watch stop
/etc/init.d/plexmediaserver-watch start
