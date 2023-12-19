# client_node.gd
class_name ClientNode
extends Control

var udp := PacketPeerUDP.new()
var connected = false

var light = 0
var prev_light = 0

var IP_ADDRESS_DEFAULT = "127.0.0.1"
var PORT_NUMBER_DEFAULT = 4242

var ip_address:String

#var p = 300000

var border_Value:int = 50
var is_on:int

@onready var connect_button = $connect
@onready var set_button = $set
@onready var ip_edit = connect_button.get_node("ip_edit")
@onready var b_edit = set_button.get_node("b_edit")
@onready var label_switch = get_node("Label")
@onready var intensity_label = $intenstiy


func switch_on():
	pass
	
func switch_off():
	pass

func set_border_val():
	pass

func connect_to_server(ip=IP_ADDRESS_DEFAULT,port=PORT_NUMBER_DEFAULT):
	udp.connect_to_host(ip,port)


func _physics_process(delta):
	
	if ip_address:
		
		udp.connect_to_host(ip_address,PORT_NUMBER_DEFAULT)
	else:
		pass
		#udp.connect_to_host(IP_ADDRESS_DEFAULT,PORT_NUMBER_DEFAULT)
	
#	if ip_address!=null:
#		connect_to_server(ip_address)
#	else:
#		connect_to_server()
	
	if !connected:
		# Try to contact server
		udp.put_packet(PackedInt64Array([border_Value]).to_byte_array())
		
	if udp.get_available_packet_count()>0:
		#print("Connected: %s" % udp.get_packet().get_string_from_utf8())
		connected = true
	
	if connected:
		var arr = udp.get_packet().to_int64_array()
		if arr.size()>0:
			intensity_label.set_text(str(arr[0]) + " lux")
			
			
			if arr[2]==0:
				label_switch.set_text("LIGHT: OFF")
			else:
				label_switch.set_text("LIGHT: ON")
		
			
			
		#label.set_text(udp.get_packet().get_string_from_utf32())
	


func _on_connect_pressed():
	
	if ip_edit.text:
		print("connecting")
		if ip_edit.get_text().is_valid_ip_address():
			ip_address = ip_edit.get_text()
	else:
		print("connecting def")
		ip_address = IP_ADDRESS_DEFAULT
		
	



func _on_set_pressed():
	border_Value = int(b_edit.get_text())
