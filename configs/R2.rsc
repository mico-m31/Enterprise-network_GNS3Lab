# 2026-07-04 14:58:30 by RouterOS 7.23.1
# system id = MVyBvyT5QQC
#
/interface bridge
add name=loopback1
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
set [ find default-name=ether7 ] disable-running-check=no
set [ find default-name=ether8 ] disable-running-check=no
/interface vlan
add interface=loopback1 name=vlan30 vlan-id=30
add interface=loopback1 name=vlan40 vlan-id=40
/ip pool
add name=vlan40 ranges=10.10.40.10-10.10.40.240
add name=vlan30 ranges=10.10.30.10-10.10.30.240
add name=dhcp_pool2 ranges=10.10.30.10-10.10.30.240
add name=dhcp_pool3 ranges=10.10.40.10-10.10.40.240
add name=dhcp_pool4 ranges=10.10.60.10-10.10.60.240
add name=dhcp_pool5 ranges=10.10.20.10-10.10.20.240
add name=dhcp_pool6 ranges=10.10.10.10-10.10.10.240
/ip dhcp-server
add address-pool=dhcp_pool2 interface=ether2 name=dhcp1 relay=10.10.30.253
add address-pool=dhcp_pool3 interface=ether2 name=dhcp2 relay=10.10.40.253
add address-pool=dhcp_pool4 interface=ether2 name=dhcp3 relay=10.10.60.253
add address-pool=dhcp_pool5 interface=ether2 name=dhcp4 relay=10.10.20.253
add address-pool=dhcp_pool6 interface=ether2 name=dhcp5 relay=10.10.10.253
/routing id
add disabled=no name=ospf select-dynamic-id=only-loopback
/routing ospf instance
add disabled=no name=ospf-instance-1 originate-default=always router-id=ospf
/routing ospf area
add disabled=no instance=ospf-instance-1 name=backbone
/snmp community
add addresses=::/0 authentication-protocol=SHA1 encryption-protocol=AES name=\
    zabbixuser security=private
/ip address
add address=10.10.8.2 interface=loopback1 network=10.10.8.2
add address=10.10.8.25/30 interface=ether1 network=10.10.8.24
add address=10.10.8.21/30 interface=ether2 network=10.10.8.20
/ip dhcp-client
add interface=ether8 name=client1
/ip dhcp-server network
add address=10.10.10.0/24 dns-server=8.8.8.8 gateway=10.10.10.254
add address=10.10.20.0/24 dns-server=8.8.8.8 gateway=10.10.20.254
add address=10.10.30.0/24 dns-server=8.8.8.8,1.1.1.1 gateway=10.10.30.254
add address=10.10.40.0/24 dns-server=8.8.8.8,1.1.1.1 gateway=10.10.40.254
add address=10.10.60.0/24 dns-server=8.8.8.8 gateway=10.10.60.254
/ip firewall nat
add action=masquerade chain=srcnat in-interface=ether2
/routing ospf interface-template
add area=backbone disabled=no interfaces=ether2
add area=backbone disabled=no interfaces=ether1
add area=backbone disabled=no interfaces=loopback1
/snmp
set enabled=yes trap-community=zabbixuser
