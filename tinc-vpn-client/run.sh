#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json

SERVERNAME=$(bashio::config 'server_name')
SERVERPUBLICKEY=$(bashio::config 'server_public_key')
TINCSERVER=$(bashio::config 'connect_to')
TINCNETNAME=$(bashio::config 'network_name')
SERVERSUBNET=$(bashio::config 'server_subnet')
CLIENTNAME=$(bashio::config 'client_name')
PUBLICKEY=$(bashio::config 'public_key')
PRIVATEKEY=$(bashio::config 'private_key')
CLIENTSUBNET=$(bashio::config 'client_subnet')
CLIENTROUTE=$(bashio::config 'client_route')
ADDRESSFAMILY=$(bashio::config 'address_family')
TINCMODE=$(bashio::config 'mode')

function init_tun(){
    mkdir -p /dev/net
    if [ ! -c /dev/net/tun ]; then
        mknod /dev/net/tun c 10 200
    fi
}

function generate_private_key(){
    tincd -n ${TINCNETNAME} -K4096
}

function generate_config_files(){
    mkdir -p /etc/tinc/${TINCNETNAME}/hosts

    cat <<EOF > /etc/tinc/${TINCNETNAME}/tinc-up
#!/bin/sh
ip link set \$INTERFACE up
ip addr add ${CLIENTSUBNET} dev \$INTERFACE
ip route add ${CLIENTROUTE} dev \$INTERFACE
EOF

    cat <<EOF > /etc/tinc/${TINCNETNAME}/tinc-down
#!/bin/sh
ip route del ${CLIENTROUTE} dev \$INTERFACE
ip addr del ${CLIENTSUBNET} dev \$INTERFACE
ip link set \$INTERFACE down
EOF

    cat <<EOF > /etc/tinc/${TINCNETNAME}/tinc.conf
Name = ${CLIENTNAME}
AddressFamily = ${ADDRESSFAMILY}
Interface = tun0
ConnectTo = ${SERVERNAME}
Mode = ${TINCMODE}

EOF

    cat <<EOF > /etc/tinc/${TINCNETNAME}/hosts/${CLIENTNAME}
Subnet = ${CLIENTSUBNET}


EOF

    cat <<EOF > /etc/tinc/${TINCNETNAME}/hosts/${SERVERNAME}
Subnet = ${SERVERSUBNET}
Address = ${TINCSERVER}


EOF

    echo ${PUBLICKEY} | base64 -d >> /etc/tinc/${TINCNETNAME}/hosts/${CLIENTNAME}
    echo ${SERVERPUBLICKEY} | base64 -d >> /etc/tinc/${TINCNETNAME}/hosts/${SERVERNAME}
    echo ${PRIVATEKEY} | base64 -d > /etc/tinc/${TINCNETNAME}/rsa_key.priv

    chmod 600 /etc/tinc/${TINCNETNAME}/rsa_key.priv
    chmod +x /etc/tinc/${TINCNETNAME}/tinc-up
    chmod +x /etc/tinc/${TINCNETNAME}/tinc-down
}

init_tun
generate_config_files

tincd -n ${TINCNETNAME} -D -d
