CONFIGDIR="$HOME/.config"

if [ -z $1 ]
then
	echo "Missing parameters, please send your platform ['note', 'desktop']"
	rm "$CONFIGDIR/hypr/monitors.conf"
	cp -rf ../.config/* "$CONFIGDIR"
else
	if [ $1 == "note" ]
	then
		ln -s "$CONFIGDIR/hypr/monitors_note.conf" "$CONFIGDIR/hypr/monitors.conf"
	elif [ $1 == "desktop" ]
	then
		ln -s "$CONFIGDIR/hypr/monitors_note.conf" "$CONFIGDIR/hypr/monitors.conf"
	fi
fi


