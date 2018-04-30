docker run -it --rm -v $PWD:/project-src -v /var/run/docker.sock:/var/run/docker.sock compulsivecoder/ubuntu-arm-dev-base /bin/bash -c "rsync -av --exclude='.git' /project-src/* /project-dest && cd /project-dest && sh init-mock-setup.sh && sh prepare.sh && sh init.sh && sh build.sh"
# 
# 
