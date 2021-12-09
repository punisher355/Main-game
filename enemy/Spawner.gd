extends Spatial

export var spawn_point = Vector3.ZERO
var AI_Amount = []
export var number = 4

var AI = preload("res://enemy/Ai/Ai.tscn")

var Spawn_location = "."

func _process(_delta):
	var tree = get_tree()
	#Gets the number of Ai on the map
	if tree.has_group("enemy"):
		AI_Amount = tree.get_nodes_in_group("enemy")
 
	if AI_Amount.size() < number:
		var unit = AI.instance()
		get_parent() .add_child(unit)
