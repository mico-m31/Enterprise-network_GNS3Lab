# 2026-07-04 14:46:55 by RouterOS 7.23.1
# system id = BoAWiwtQ8+J
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
/ip pool
add name=hs-pool-4 ranges=10.10.10.2-10.10.10.14
add name=dhcp_pool1 ranges=10.10.10.10-10.10.10.240
add name=dhcp_pool2 ranges=10.10.20.10-10.10.20.240
add name=dhcp_pool3 ranges=10.10.60.10-10.10.60.240
add name=dhcp_pool4 ranges=10.10.60.10-10.10.60.240
add name=dhcp_pool5 ranges=10.10.10.10-10.10.10.240
add name=dhcp_pool6 ranges=10.10.20.10-10.10.20.240
/routing id
add disabled=no id=10.10.8.1 name=ospf select-dynamic-id=""
/routing ospf instance
add disabled=no name=ospf-instance-1 router-id=ospf
/routing ospf area
add disabled=no instance=ospf-instance-1 name=backbone
/snmp community
add addresses=::/0 authentication-protocol=SHA1 encryption-protocol=AES name=\
    zabbixuser security=private
/ip address
add address=10.10.8.1 interface=loopback1 network=10.10.8.1
add address=10.10.8.13/30 interface=ether2 network=10.10.8.12
add address=10.10.8.17/30 interface=ether3 network=10.10.8.16
/ip dhcp-client
add default-route-tables=main interface=ether1 name=client1
/ip dhcp-server
add address-pool=dhcp_pool1 interface=ether2 name=dhcp1 relay=10.10.10.253
add address-pool=dhcp_pool2 interface=ether2 name=dhcp2 relay=10.10.20.253
add address-pool=dhcp_pool3 interface=ether3 name=dhcp3 relay=10.10.60.253
add address-pool=dhcp_pool4 interface=ether2 name=dhcp4 relay=10.10.60.253
add address-pool=dhcp_pool5 interface=ether3 name=dhcp5 relay=10.10.10.253
add address-pool=dhcp_pool6 interface=ether3 name=dhcp6 relay=10.10.20.253
/ip dhcp-server network
add address=10.10.10.0/24 dns-server=10.10.120.3 gateway=10.10.10.254
add address=10.10.20.0/24 dns-server=10.10.120.3 gateway=10.10.20.254
add address=10.10.60.0/24 dns-server=10.10.120.3 gateway=10.10.60.254
/ip dns
set servers=8.8.8.8
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    in-interface=ether2
add action=masquerade chain=srcnat in-interface=ether3
/routing ospf interface-template
add area=backbone disabled=no interfaces=ether2
add area=backbone disabled=no interfaces=ether3
add area=backbone disabled=no interfaces=loopback1
/snmp
set contact=zabbixuser enabled=yes location=coreEdge trap-community=\
    zabbixuser
