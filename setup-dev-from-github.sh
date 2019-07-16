echo ""
echo "Setting up GreenSense index from GitHub"
echo ""

BRANCH=$1

if [ "$BRANCH" = "" ]; then
  if [ -d ".git" ]; then
    BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  else
    BRANCH="master"
  fi
fi

echo "  Branch: $BRANCH"

if ! type "git" > /dev/null; then
  sudo apt-get update && sudo apt-get install -y git
fi

echo ""
echo "  Launching git clone..."
git clone --recursive https://github.com/GreenSense/Index.git GreenSense/Index -b $BRANCH || exit 1

echo ""
echo "  Current directory:"
echo "    $PWD"

INDEX_DIR="GreenSense/Index" && \

echo ""
echo "  GreenSense index directory:" && \
echo "  $INDEX_DIR" && \

cd $INDEX_DIR && \

echo ""
echo "  Launching prepare-dev.sh script..."
sudo bash prepare-dev.sh || exit 1

echo ""
echo "  Launching init-runtime.sh script..."
sh init-runtime.sh || exit 1

echo ""
echo "The GreenSense index is initialized and ready to use."


