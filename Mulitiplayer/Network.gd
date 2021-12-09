extends Node

var MP = false

#used port and number of players
const DEFAULT_PORT = 55555
const MAX_PLAYERS = 4

# Ip varables 
var DEFAULT_IP = ""
var host_ip = ""

var players = { }
var self_data = { 
	name = '', 
	position = Vector3(0,5,0)
}

onready var player = "res://MultiPlayer.tscn"

signal player_disconnected
signal server_disconnected

func _ready():
	#gets the local ip of current device 
	for ip in IP.get_local_addresses():
		 if ip.begins_with("192.168."): DEFAULT_IP = ip

	get_tree().connect('network_peer_disconnected', self, 'player_disconnected')
	get_tree().connect('network_peer_connected', self, 'player_connected')

func create_server(player_nickname):
	self_data.name = player_nickname
	players[1] = self_data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)

func connect_to_server(player_nickname):
	self_data.name = player_nickname
	get_tree().connect('connected_to_server', self, 'connected_to_server')
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)

func connected_to_server():
	var local_player_id = get_tree().get_network_unique_id()
	players[local_player_id] = self_data
	rpc('send_player_info', local_player_id, self_data)

func player_disconnected(id):
	players.erase(id)

func player_connected(connected_player_id):
	var local_player_id = get_tree().get_network_unique_id()
	if not(get_tree().is_network_server()):
		rpc_id(1, 'request_player_info', local_player_id, connected_player_id)

remote func request_player_info(request_from_id, player_id):
	if get_tree().is_network_server():
		rpc_id(request_from_id, 'send_player_info', player_id, players[player_id])

#request all players in the current session.
remote func _request_players(request_from_id):
	if get_tree().is_network_server():
		for peer_id in players:
			if( peer_id != request_from_id):
				rpc_id(request_from_id, 'send_player_info', peer_id, players[peer_id])

remote func send_player_info(id, info):
	players[id] = info
	var new_player = load(player).instance()
	new_player.name = str(id)
	new_player.set_network_master(id)
	$'/root/Spatial/'.add_child(new_player)
	new_player.init(info.name, info.position, true)

func update_position(id, position):
	players[id].position = position
