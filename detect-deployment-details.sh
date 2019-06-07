BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

echo ""
echo "Detecting deployment details..."

if [ "$BRANCH" = "lts" ]; then
  echo "  Garden: lts"
  INSTALL_HOST=$LTS_INSTALL_HOST
  INSTALL_SSH_USERNAME=$LTS_INSTALL_SSH_USERNAME
  INSTALL_SSH_PASSWORD=$LTS_INSTALL_SSH_PASSWORD
  INSTALL_SSH_PORT=$LTS_INSTALL_SSH_PORT
  INSTALL_MQTT_HOST=$LTS_MQTT_HOST
fi
if [ "$BRANCH" = "master" ]; then
  echo "  Garden: master"
  INSTALL_HOST=$MASTER_INSTALL_HOST
  INSTALL_SSH_USERNAME=$MASTER_INSTALL_SSH_USERNAME
  INSTALL_SSH_PASSWORD=$MASTER_INSTALL_SSH_PASSWORD
  INSTALL_SSH_PORT=$MASTER_INSTALL_SSH_PORT
  INSTALL_MQTT_HOST=$MASTER_MQTT_HOST
fi
if [ "$BRANCH" = "dev" ]; then
  echo "  Garden: dev"
  INSTALL_HOST=$DEV_INSTALL_HOST
  INSTALL_SSH_USERNAME=$DEV_INSTALL_SSH_USERNAME
  INSTALL_SSH_PASSWORD=$DEV_INSTALL_SSH_PASSWORD
  INSTALL_SSH_PORT=$DEV_INSTALL_SSH_PORT
  INSTALL_MQTT_HOST=$DEV_MQTT_HOST
fi

if [ -f "set-deployment-details.sh.security" ]; then
  echo "  Found set-deployment-details.sh.security script. Executing."
  . ./set-deployment-details.sh.security
fi

echo "  Install host: $INSTALL_HOST"
echo "    SSH username: $INSTALL_SSH_USERNAME"
echo "    SSH password: [hidden]"
echo "    SSH port: $INSTALL_SSH_PORT"
echo "  MQTT host: $INSTALL_MQTT_HOST"

echo "  Finished detecting deployment details."
echo ""
