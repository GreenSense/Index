
# Example:
# sh upload-irrigator-sketch-esp.sh "myirrigator" ttyUSB0

DIR=$PWD

MOCK_FLAG_FILE="is-mock-setup.txt"
IS_MOCK_SETUP=0
if [ -f "$MOCK_FLAG_FILE" ]; then
  IS_MOCK_SETUP=1
  echo "Is mock setup"
fi

DEVICE_NAME=$1
SERIAL_PORT=$2

if [ ! $SERIAL_PORT ]; then
  SERIAL_PORT="ttyUSB0"
fi

if [ ! $DEVICE_NAME ]; then
  echo "Specify the device name as an argument."
  exit 1
fi

echo "Uploading irrigator ESP8266 sketch"

echo "Serial port: $SERIAL_PORT"

BASE_PATH="sketches/irrigator/SoilMoistureSensorCalibratedPumpESP"

cd $BASE_PATH

# Pull the security files from the index into the project
sh pull-security-files.sh && \

# Inject security details
sh inject-security-settings.sh && \

# Inject device name
sh inject-device-name.sh "$DEVICE_NAME" && \

# Inject version into the sketch
sh inject-version.sh && \

# Build the sketch
sh build.sh || exit 1

# Upload the sketch
if [ $IS_MOCK_SETUP = 0 ]; then
    sh upload.sh "/dev/$SERIAL_PORT" || exit 1
else
    echo "[mock] sh upload.sh /dev/$SERIAL_PORT"
fi

# Clean all settings
sh clean-settings.sh && \

cd $DIR && \

if [ $IS_MOCK_SETUP = 0 ]; then
    sh $BASE_PATH/irrigator-serial.sh "/dev/$SERIAL_PORT" || exit 1
else
    echo "[mock] sh irrigator-serial.sh /dev/$SERIAL_PORT"
fi

echo "Finished upload"