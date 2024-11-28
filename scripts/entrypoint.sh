#!/bin/sh

scriptDir=$(dirname "$0")

extractScriptPath=$scriptDir/extract-zip.sh

echo $PUBLIC_TOKEN_SSH | base64 -d >> /root/.ssh/authorized_keys
echo $SERVER_SSH_SECRETS | base64 -d | "$extractScriptPath" /etc/ssh

/usr/sbin/sshd
sslh -F /etc/sslh.conf
npm start