#!/bin/bash

service cron start
service ssh start

cd /sepi && ./sepiscr
