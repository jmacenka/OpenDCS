#!/bin/sh
# SCRIPT FOR STARTING ALL SERVICES IN THIS PROJECT
# REMOVE NOT REQUIRED SERVICES BY OUT-COMMENTING THEM

# Preprocessing
echo "Now: Generating required Docker-Networks..."
docker network create nginx-proxy-manager

# Starting Services
echo "Now: Starting services..."
docker-compose -f ./../apps/nginx-proxy-manager/docker-compose.yml up -d                                # nginx-proxy-manager
docker-compose -f ./../apps/portainer/docker-compose.yml up -d                                          # portainer
docker-compose -f ./../apps/heimdall/docker-compose.yml up -d                                           # heimdall
docker-compose -f ./../apps/guacamole/docker-compose.yml up -d                                          # guacamole
docker-compose -f ./../apps/code-server/docker-compose.yml up -d                                        # Code-Server
docker-compose -f ./../apps/grafana-influxdb-nodered/docker-compose.yml up -d                           # grafana-influxdb-nodered                           
docker-compose -f ./../apps/jupyter-notebook/docker-compose.yml up -d                                   # jupyter-notebook
docker-compose -f ./../apps/codimd/docker-compose.yml up -d                                             # CodiMD Document-Editor

# Postprocessing
echo "Now: Generating InfluxDB..."
curl --unix-socket /var/run/docker.sock -XPOST 'http://influxdb:8086/query' --data-urlencode "q=CREATE DATABASE BW"                       # generating influxdb DATABASE BW
#echo "Now: Testing successfull setup of services..."
# TODO: Make automated testing for all services

echo ""
echo "Everything up and running..."
echo "All done!"