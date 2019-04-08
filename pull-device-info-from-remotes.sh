echo "Pulling device info from remote indexes..."

for REMOTE_DIR in remote/*; do
  REMOTE_NAME=$(cat "$REMOTE_DIR/name.txt")
  
  echo "Remote name: $REMOTE_NAME"

  sh pull-device-info-from-remote.sh $REMOTE_NAME
done