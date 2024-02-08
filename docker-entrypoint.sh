#!/bin/bash

service cron start
service ssh start

sudo -i -u ubuntu cd ~/sepi && nohup ./sepiscr &
