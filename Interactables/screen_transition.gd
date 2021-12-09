extends Area

export var next_map = "res://Maps/Start_town.tscn"
export var location = Vector3.ZERO

func _on_screen_transition_body_entered(body):
	if body. is_in_group("Player"):
		Gear.Location = location
		get_tree().change_scene(next_map)
