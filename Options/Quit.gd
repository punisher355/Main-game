extends Control


func _ready():
	pass # Replace with function body.


func _on_titlescreen_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Title screen/Title_Screen.tscn")

func _on_closegame_pressed():
	get_tree().quit()

func _on_Load_game_pressed():
	get_tree().paused = false
	SaveData._load_Game()
	SaveData.Update_load_varables()
	get_tree().change_scene(SaveData.map)
