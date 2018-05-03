# python
if ! type "python" > /dev/null; then
  sudo apt-get install -y python
fi

if ! type "pip" > /dev/null; then
  sudo apt-get install -y python-pip
fi

if ! type "pio" > /dev/null; then
  #mkdir -p ~/.platformio
  #sudo chown -R $USER ~/.platformio


#  pip install --upgrade pip && \
#  pip install --user setuptools testresources pyOpenSSL ndg-httpsclient pyasn1 && \

  sudo python -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/master/scripts/get-platformio.py)"
else
  echo "Platform.io is already installed. Skipping."
fi
