#!/bin/bash

####################################################################
# Assumption: k8s/kubeadm was deployed using podcidr=10.240.0.0/16 #
####################################################################

# Allow pod to pod communication
iptables -A FORWARD -s 10.240.0.0/16 -j ACCEPT
iptables -A FORWARD -d 10.240.0.0/16 -j ACCEPT

# Allow communication across hosts
#XXX  I think this is not needed
ip route add 10.240.1.0/24 via 10.10.0.11 dev ens4

# Allow outgoing internet
iptables -t nat -A POSTROUTING -s 10.240.0.0/24 ! -o cni0 -j MASQUERADE