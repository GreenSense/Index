echo "Updating GreenSense plug and play..."

BRANCH=$1
INSTALL_DIR=$2

EXAMPLE_COMMAND="Example:\n..sh [Branch] [InstallDir]"

if [ ! $BRANCH ]; then
  BRANCH="master"
fi

if [ "$INSTALL_DIR" = "?" ]; then
    INSTALL_DIR="/usr/local/GreenSense/Index"
fi
if [ ! "$INSTALL_DIR" ]; then
    INSTALL_DIR="/usr/local/GreenSense/Index"
fi

echo "Branch: $BRANCH"
echo "Install dir: $INSTALL_DIR"


INDEX_DIR="$INSTALL_DIR"
GREENSENSE_DIR="$(dirname $INSTALL_DIR)"
BASE_DIR="$(dirname $GREENSENSE_DIR)"

PNP_INSTALL_DIR="$BASE_DIR/ArduinoPlugAndPlay"


echo "Checking for ArduinoPlugAndPlay install dir..."
if [ ! -d $PNP_INSTALL_DIR ]; then
  echo "ArduinoPlugAndPlay doesn't appear to be installed at:"
  echo "  $PNP_INSTALL_DIR"
  echo "Use the install-plug-and-play-from-web-sh script instead."
  exit 1
fi

INDEX_DIR=$INSTALL_DIR

echo "Checking for GreenSense index dir..."
if [ ! -d $INDEX_DIR ]; then
  echo "GreenSense Index doesn't appear to be installed at:"
  echo "  $INDEX_DIR"
  echo "Use the install-plug-and-play-from-web-sh script instead."
  exit 1
fi

echo "Moving to GreenSense index dir..."
cd $INDEX_DIR

WIFI_NAME=$(cat wifi-name.security)
WIFI_PASSWORD=$(cat wifi-password.security)

echo "WiFi Name: $WIFI_NAME"
echo "WiFi Password: [hidden]"

MQTT_HOST=$(cat mqtt-host.security)
MQTT_USERNAME=$(cat mqtt-username.security)
MQTT_PASSWORD=$(cat mqtt-password.security)
MQTT_PORT=$(cat mqtt-port.security)

echo "MQTT Host: $MQTT_HOST"
echo "MQTT Username: $MQTT_USERNAME"
echo "MQTT Password: [hidden]"
echo "MQTT PORT: $MQTT_PORT"

echo "Publishing status to MQTT..."
sh mqtt-publish.sh "/garden/StatusMessage" "Upgrading" &

echo "Giving the UI time to receive the status update..."
sleep 5

echo "Stopping arduino plug and play..."
sh systemctl.sh stop arduino-plug-and-play.service

echo "Stopping garden..."
sh stop-garden.sh || exit 1

echo "Updating index..."
sh update-all.sh || exit 1

echo "Upgrading..."
sh upgrade.sh || exit 1

echo "Reinitializing index..."
sh init-runtime.sh || exit 1

echo "Updating ArduinoPlugAndPlay (by downloading update-from-web.sh file)..."
wget -q --no-cache -O - https://raw.githubusercontent.com/CompulsiveCoder/ArduinoPlugAndPlay/$BRANCH/scripts-web/update-from-web.sh | bash -s -- $BRANCH $PNP_INSTALL_DIR || exit 1

echo "Recreating UI..."
sh recreate-garden-ui.sh || exit 1

echo "Recreating garden services..."
sh recreate-garden-services.sh || exit 1

echo "Reloading systemctl..."
if [ ! -f "is-mock-systemctl.txt" ]; then
  systemctl daemon-reload  || exit 1
else
  echo "[mock] systemctl daemon-reload"
fi

echo "Moving to GreenSense index dir..."
cd $INDEX_DIR

echo "Starting arduino plug and play..."
sh systemctl.sh start arduino-plug-and-play.service

echo "Giving plug and play time to start..."
sleep 10

echo "Start garden services..."
sh start-garden.sh || exit 1

echo "Giving services time to start..."
sleep 10

echo "Publishing status to MQTT..."
sh mqtt-publish.sh "/garden/StatusMessage" "Upgrade Complete" || echo "MQTT publish failed."


echo "Finished reinstalling GreenSense plug and play!"
