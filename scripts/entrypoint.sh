#!/bin/sh

scriptDir=$(dirname "$0")
startSSH=$scriptDir/start-ssh-server.sh

$startSSH
sslh -F /etc/sslh.conf
npm start