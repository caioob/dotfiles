CONFIGDIR="$HOME/.config"
PLATFORM=$1


linking () {
	linkingType="$1"
	linkingPlatform="$2"
	echo "Removing old $linkingType.conf link if existent"
	rm -f "$CONFIGDIR/hypr/$linkingType.conf" && echo "Links successfully removed"
	echo "Creating new links"
	ln -s "$CONFIGDIR/hypr/$linkingType""_""$linkingPlatform.conf" "$CONFIGDIR/hypr/$linkingType.conf"
	echo "New $linkingType.conf created"
}

if [ -z $1 ]
then
	echo "Missing parameters, please send your platform ['note', 'desktop']"
else
	if [ $1 == "note" ]
	then
		cp -rf ../.config/* "$CONFIGDIR"
		cp -rf ../.config/wallpapers "$CONFIGDIR"
		linking "monitors" $PLATFORM
		linking "input" $PLATFORM
	elif [ $1 == "desktop" ]
	then
		cp -rf ../.config/* "$CONFIGDIR"
		cp -rf ../.config/wallpapers "$CONFIGDIR"
		linking "monitors" $PLATFORM
		linking "input" $PLATFORM
	fi
fi


