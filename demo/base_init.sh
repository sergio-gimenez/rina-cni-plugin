#!/bin/bash

########################################################################################################
# Assumption: Cluter CIDR is 10.240.0.0/16, i.e., k8s/kubeadm was deployed using podcidr=10.240.0.0/16 #
########################################################################################################

# display usage if the script is not run as root user
if [[ "$EUID" -ne 0 ]]; then
    echo "This script must be run as root!"
    exit 1
fi

# Allow pod to pod communication
iptables -A FORWARD -s 10.240.0.0/16 -j ACCEPT
iptables -A FORWARD -d 10.240.0.0/16 -j ACCEPT

# TODO Test internet access from pods
# Allow outgoing internet
# iptables -t nat -A POSTROUTING -s 10.240.0.0/24 ! -o cni0 -j MASQUERADE