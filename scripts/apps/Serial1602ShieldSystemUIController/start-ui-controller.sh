# Disabled because it shouldn't be needed. The package should already be initialised.
#sh init.sh

echo "Launching UI controller."

mono Serial1602ShieldSystemUIController/lib/net40/Serial1602ShieldSystemUIControllerConsole.exe $1 $2 $3 $4 $5 $6 $7 $8 $9
