


# server_node.gd
class_name ServerNode
extends Node

var server := UDPServer.new()
var peers = []

var connected = false

@onready var sensor = get_parent()

func _ready():
	server.listen(4242)

func send_sensor_data(peer):
	peer.put_packet(sensor.get_data().to_byte_array())
	#print(PackedByteArray([str(sensor.get_data())]))
	
	
	

func _physics_process(delta):
	server.poll() 
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet = peer.get_packet()
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		print("Received data: %s" % str(packet.to_int64_array()))
		peers.append(peer)

		
		
	if peers.size()>0:
		for peer in peers:
			send_sensor_data(peer)
