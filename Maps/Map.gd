extends Spatial

onready var BGM = $BGM

onready var node = preload("res://Player/Player.tscn")
onready var palyer = preload("res://MultiPlayer.tscn")

func _ready():
	if Network.MP == true:
		get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
		get_tree().connect('server_disconnected', self, '_on_server_disconnected')
	
		var new_player = palyer.instance()
		new_player.name = str(get_tree().get_network_unique_id())
		new_player.set_network_master(get_tree().get_network_unique_id())
		add_child(new_player)
		var info = Network.self_data
		new_player.init(info.name, info.position, false)

	else:
		var new_player = node.instance()
		add_child(new_player)
		new_player.transform.origin = Gear.Location
	
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global._load_Options()

func _on_player_disconnected(id):
	get_node(str(id)).queue_free()

func _on_server_disconnected():
	get_tree().change_scene("res://Title screen/Title_Screen.tscn")
	
func _process(_delta):
	#changed the background music volume
	BGM.set_volume_db(Global.Music_Volume) 

