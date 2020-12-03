from toccoag/openshift-nginx:stable

# Builds a container that can run on OpenShift and can be SSHd into as root using a password.
# This container can act as a node for the purposes of testing ssh and run function automation scripts

# This container *IS NOT SECURE* and is intended from testing purposes only, it should *NOT BE USED IN PRODCUTION*

EXPOSE 22

RUN apt-get clean \
    && apt-get -y install openssh-server \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin  yes/' /etc/ssh/sshd_config \ 
    && service ssh restart \
    && service ssh status 

COPY hadoop /usr/bin/hadoop
RUN chmod +x /usr/bin/hadoop 
