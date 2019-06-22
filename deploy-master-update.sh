
BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [ "$BRANCH" = "master" ]; then

  echo "Deploying master branch update..."
  echo "Host: $MASTER_INSTALL_HOST"

  echo ""
  
  echo "Waiting for deployment to unlock..."
  . ./detect-deployment-details.sh
  sshpass -p $INSTALL_SSH_PASSWORD ssh -o "StrictHostKeyChecking no" $INSTALL_SSH_USERNAME@$INSTALL_HOST "cd /usr/local/GreenSense/Index && bash wait-for-unlock.sh" || echo "Failed to wait for unlock. Script likely doesn't exist because it hasn't been installed."
  
  echo "Updating GreenSense plug and play on remote host..."

  sshpass -p $MASTER_INSTALL_SSH_PASSWORD ssh -o "StrictHostKeyChecking no" $MASTER_INSTALL_SSH_USERNAME@$MASTER_INSTALL_HOST "wget --no-cache -O - https://raw.githubusercontent.com/GreenSense/Index/$BRANCH/scripts-web/update-plug-and-play-from-web.sh | bash -s -- $BRANCH"
  
  START_WAIT_TIME=60
  
  echo "Giving services time to start ($START_WAIT_TIME seconds)..."
  sleep $START_WAIT_TIME
  
  echo "Checking deployment..."
  bash check-deployment.sh || exit 1

  echo "Finished deployment."
else
  echo "You're not in the master branch. Skipping master deployment."
fi
