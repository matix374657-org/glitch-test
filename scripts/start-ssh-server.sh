#!/bin/sh

mkdir ${HOME}/custom_ssh

cat << EOF > ${HOME}/custom_ssh/sshd_config
HostKey ${HOME}/custom_ssh/ssh_host_rsa_key
HostKey ${HOME}/custom_ssh/ssh_host_dsa_key
AuthorizedKeysFile  .ssh/authorized_keys
ChallengeResponseAuthentication no
Subsystem   sftp    /usr/lib/ssh/sftp-server
PidFile ${HOME}/custom_ssh/sshd.pid
PermitRootLogin yes
PasswordAuthentication no
EOF

/usr/sbin/sshd -f ${HOME}/custom_ssh/sshd_config
echo "----- Process ID : ${HOME}/custom_ssh/sshd.pid -------"