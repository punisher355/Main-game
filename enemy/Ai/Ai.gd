extends KinematicBody

# navagation varables
var path = []
var path_index = 0

var Map_Navigation = null
var Target = null

#movement varables
export var speed = 10
var velocity = Vector3.ZERO


# AI health remaining
export var enemy_health = 3

# function plays when AI is hit 
func OnHit(dammage):
	enemy_health -= dammage
	if enemy_health <= 0:
		queue_free()


func _ready():
	var tree = get_tree()
	#sets the Target as the palyer
	if tree.has_group("Player"):
		Target = tree.get_nodes_in_group("Player")[0]
	#sets the nav mesh
	if tree.has_group("Map_Navigation"):
		Map_Navigation = tree.get_nodes_in_group("Map_Navigation")[0]

func _physics_process(_delta):
	navigate()
	generate_path()

# looks up the Array and moves
func navigate():
	if path.size() > 0:
		velocity = global_transform.origin.direction_to(path[1]) * speed
		velocity = move_and_slide(velocity)
		
# Define the next position
func generate_path():
	if Target != null and Map_Navigation != null:
		path = Map_Navigation.get_simple_path(global_transform.origin, Target.global_transform.origin)

