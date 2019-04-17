
INIT_SCRIPT_FILE_URL="https://raw.githubusercontent.com/GreenSense/Index/master/scripts/apps/BridgeArduinoSerialToMqttSplitCsv/init.sh"
curl -o init.sh -f $INIT_SCRIPT_FILE_URL || echo "Failed to download init.sh file"

sh init.sh || exit 1

mono BridgeArduinoSerialToMqttSplitCsv/lib/net40/BridgeArduinoSerialToMqttSplitCsv.exe $1 $2 $3 $4 $5 $6 $7 $8 $9
