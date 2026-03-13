/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
set [ find default-name=ether7 ] disable-running-check=no
set [ find default-name=ether8 ] disable-running-check=no
/port
set 0 name=serial0
/routing ospf instance
add disabled=no name=default router-id=2.2.2.2
/routing ospf area
add disabled=no instance=default name=backbone
/ip address
add address=10.10.80.9/30 interface=ether3 network=10.10.80.8
add address=10.10.80.25/30 interface=ether2 network=10.10.80.24
add address=10.10.80.21/30 interface=ether4 network=10.10.80.20
/ip dhcp-client
add interface=ether1
/routing ospf interface-template
add area=backbone disabled=no interfaces=ether1
add area=backbone disabled=no interfaces=ether2
add area=backbone disabled=no interfaces=ether3
add area=backbone disabled=no interfaces=ether4
/system note
set show-at-login=no
