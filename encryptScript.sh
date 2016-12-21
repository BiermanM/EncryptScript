#!/bin/bash

if [ ! -f "$1" ]
then
	echo "Error, script not found."
elif ! (echo "$1" | grep -q "/home/$USER/")
then
	echo "Error, please type the full path of the script."
elif ! (cat "$1" | grep -q "#!/bin/bash")
then
	echo "Error, file is not a script."
else
	chmod +x "$1"
	chmod 777 "$1"
	
	wget http://www.datsi.fi.upm.es/~frosal/sources/shc-3.8.7.tgz > /dev/null 2>&1
	tar xvfz shc-3.8.7.tgz > /dev/null
	cd shc-3.8.7
	make > /dev/null

	echo "The original script will be deleted after it is encrypted to a new file. Press enter to proceed."
	read enter

	./shc -f "$1"
	cd ..
	rm -f "$1"
	rm -f "$1.x.c"
	chmod 111 "$1.x"
	chmod +x “$1.x”
	
	rm -f shc-3.8.7.tgz
	rm -rf shc-3.8.7

	echo "Script has been successfully encrypted."
fi
