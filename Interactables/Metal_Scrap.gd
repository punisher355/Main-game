extends RigidBody

#value of scrap when collected
export var value = 1

#timer count
var timer = 0

#if player collected 
var pickup = false

#sound it makes when collected
onready var sound = $AudioStreamPlayer

func _process(_delta):
	timer += 1
	if timer >= 10800:
		queue_free()

func _on_Area_body_entered(body):
	#checks if player touches it
	if body. is_in_group("Player") and pickup == false:
		#Recorce that goes up oi nitem collected
		Gear.Metal_scrap += value
		#plays the sound when item is collected
		sound.set_volume_db(Global.sound_effec_volume)
		sound.play()
		pickup = true
		#removes scrap once its picked up 
		get_node(".").hide()
		get_node("CollisionShape").disabled = true
		timer = 10680
