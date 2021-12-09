extends VBoxContainer

onready var Enter_IP = $"Enter IP/Enter IP2"
onready var enter_name = $"Enter Name/Enter Name2"

onready var map = "res://Maps/Start_room.tscn"

var player_name = ""

func _ready():
	#Dispalys the current IP adress
	Enter_IP.text = Network.DEFAULT_IP
	enter_name.text = "Test"

func _on_Host_Game_pressed():
	player_name = enter_name.text
	Network.create_server(player_name)
	print("hosting server")
	Network.MP = true
	get_tree().change_scene(map)
	
	
func _on_Join_Game_pressed():
	#sends the entered IP to the network script
	Network.host_ip = Enter_IP.text 
	player_name = enter_name.text
	Network.connect_to_server(player_name)
	Network.MP = true
	get_tree().change_scene(map)

