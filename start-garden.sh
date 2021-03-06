echo ""
echo "Starting all garden services"
echo ""

DIR=$PWD

sh start-supervisor.sh || exit 1

DEVICES_DIR="devices"

if [ -d "$DEVICES_DIR" ]; then
    for d in $DEVICES_DIR/*; do
        DEVICE_NAME=$(cat $d/name.txt)
        DEVICE_LABEL=$(cat $d/label.txt)        
        
        echo "$DEVICE_LABEL"
        
        sh start-garden-device.sh $DEVICE_NAME
       
        echo ""
    done
else
    echo "No device info found in $DEVICES_DIR"
fi
