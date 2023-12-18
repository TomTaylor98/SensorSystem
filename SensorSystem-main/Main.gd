


# server_node.gd
class_name ServerNode
extends Node

var server := UDPServer.new()
var peers = []

@onready var world = $WorldEnvironment

func _ready():
	server.listen(4242)

func _process(delta):
	server.poll() # Important!
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet = peer.get_packet()
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		print("Received data: %s" % [packet.get_string_from_utf8()])
		# Reply so it knows we received the message.
		peer.put_packet(packet)
		# Keep a reference so we can keep contacting the remote peer.
		peers.append(peer)

	if peers.size()>0:
		for peer in peers:
			peer.put_packet(str(world.environment.background_intensity).to_utf8_buffer())
