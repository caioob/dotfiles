CONFIGDIR="$HOME/.config"

if [ -z $1 ]
then
	echo "Missing parameters, please send your platform ['note', 'desktop']"
	cp -rf ../.config/* "$CONFIGDIR"
else
	if [ $1 == "note" ]
	then
		echo "Removing old monitors.conf link if existent"
		rm -f "$CONFIGDIR/hypr/monitors.conf" && echo "monitors.conf link successfulky removed"
		echo "Creating new link"
		ln -s "$CONFIGDIR/hypr/monitors_note.conf" "$CONFIGDIR/hypr/monitors.conf"
		echo "New link created"
	elif [ $1 == "desktop" ]
	then
		echo "Removing old monitors.conf link if existent"
		rm -f "$CONFIGDIR/hypr/monitors.conf" && echo "monitors.conf link successfulky removed"
		echo "Creating new link"
		ln -s "$CONFIGDIR/hypr/monitors_note.conf" "$CONFIGDIR/hypr/monitors.conf"
		echo "New link created"
	fi
fi


