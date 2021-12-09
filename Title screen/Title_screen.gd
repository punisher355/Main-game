extends Control

onready var options_node := $"VBoxContainer/Options"
onready var multiplayer_node := $"VBoxContainer/Mulitiplayer"

onready var BGM = $BGM

# newgame button
func _on_New_Game_pressed():
	get_tree().change_scene("res://Character_Customization/Character_Customization.tscn")
  
#load game button
func _on_Load_Game_pressed():
	SaveData._load_Game()
	SaveData.Update_load_varables()
	get_tree().change_scene(SaveData.map)

#Multiplayer button
func _on_Mulitiplayer_pressed():
	options_node.hide()
	multiplayer_node.visible = !multiplayer_node.visible

#option button
func _on_Options_pressed():
	multiplayer_node.hide()
	options_node.visible = !options_node.visible

#close game button
func _on_Close_Game_pressed():
	get_tree().quit()

func _process(_delta):
	#changed the background music volume
	BGM.set_volume_db(Global.Music_Volume) 
