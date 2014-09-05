#!/bin/sh

echo "installing curl"
apt-get --yes install curl
if [ ! -d "init" ]; then
    echo "Error cannot find init folder"
    return 0
fi
if [ ! -d "watch" ]; then
    echo "Error cannot find watch folder"
    return 0
fi

chmod +x init/*
chmod +x watch/*
echo "Copying init files"
cp -fp init/* /etc/init.d/

echo "Creating plex watch folder"
mkdir -p /var/lib/plexmediaserver/watch

echo "copying watch scripts"
cp -fp watch/*-watch /var/lib/plexmediaserver/watch

echo "changing permissions"
chown -hR plex:nogroup /var/lib/plexmediaserver/watch

echo "Running on boot"
update-rc.d plexmediaserver-watch defaults
update-rc.d bitcasa-watch defaults

echo "starting scripts"
/etc/init.d/bitcasa-watch stop
/etc/init.d/bitcasa-watch start
/etc/init.d/plexmediaserver-watch stop
/etc/init.d/plexmediaserver-watch start
