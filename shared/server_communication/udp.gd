extends Node

var Config_loader = load("res://shared/configLoader.gd").new()
var config = Config_loader.load_config()
var server_url = config.udpServer
var server_port = config.udpServerPort

var to_sand: Array[PackedByteArray] = []
var udp_client: PacketPeerUDP
var is_ready: bool = false

func init_connection():
	udp_client = PacketPeerUDP.new()
	var callback = udp_client.connect_to_host(server_url, server_port)
	is_ready = true
	set_process(true)
	_start_queue()

func send_message(message: String):
	var packet = message.to_utf8_buffer()
	if(!is_ready):
		to_sand.push_back(packet)
		return
	
	if(to_sand.size() == 0):
		udp_client.put_packet(packet)
	else:
		to_sand.push_back(packet)

func _process(delta):
	if udp_client.get_available_packet_count() > 0:
		var received_data = udp_client.get_packet().get_string_from_utf8()
		print("Received from server: %s" % received_data)

func _start_queue():
	for message in to_sand:
		udp_client.put_packet(message)
