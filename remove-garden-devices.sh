echo ""
echo "Removing garden device services"
echo ""

DIR=$PWD

SYSTEMCTL_SCRIPT="systemctl.sh"

SUDO=""
if [ ! "$(id -u)" -eq 0 ]; then
    SUDO='sudo'
fi

echo ""
echo "Device Info"
echo ""

if [ -d "devices" ]; then
  rm devices -r
fi

echo ""
echo "Mobile UI Settings"
echo ""

cd mobile/linearmqtt && \
sh reset.sh && \
cd $DIR


echo ""
echo "MQTT Bridge Services"
echo ""

for filename in scripts/apps/BridgeArduinoSerialToMqttSplitCsv/svc/*.service; do
  [ -f "$filename" ] || break
  shortname=$(basename $filename)
  echo "Removing service: $filename" && \
  rm -v $filename || exit 1
  echo ""
done

echo ""
echo "Installed services"
echo ""

for filename in /lib/systemd/system/greensense-*.service; do
  [ -f "$filename" ] || break
  shortname=$(basename $filename)
  echo "Removing service: $shortname" && \
  echo "" && \
  sh $SYSTEMCTL_SCRIPT stop "$shortname" && \
  sh $SYSTEMCTL_SCRIPT disable "$shortname" || exit 1
  
  if [ ! -f "is-mock-systemctl.txt" ]; then
    $SUDO rm -v $filename || exit 1
  fi
  echo "" 
done

echo "Finished removing garden device services"
