extends StaticBody

export var target_health = 1

#item droped when destroyed 
const Scrap_preload = preload("res://Interactables/Metal_Scrap.tscn")
var scrap_remaining = 1

#sound it makes when destroyed
onready var sound = $AudioStreamPlayer

#checks if crate is destroyed
var destroyed = false

func OnHit(dammage):
	target_health -= dammage
	if target_health <= 0:
		#sets the amount of scrap droped 
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		rng = rng.randi_range(0,1)
		scrap_remaining = rng 
		print (scrap_remaining)
		scrap()

func scrap():
	if scrap_remaining > 0:
		#Creats scrap
		var Scrap = Scrap_preload.instance()
		Scrap.global_transform.origin = global_transform.origin
		get_parent() .add_child(Scrap)
		#checks if all scrap has droped
		scrap_remaining -= 1
		scrap()
	if scrap_remaining <= 0:
		destroyed = true
		#plays the sound when item is collected
		sound.set_volume_db(Global.sound_effec_volume)
		sound.play()
		#hides object 
		get_node(".").hide()
		get_node("CollisionShape").disabled = true

#removes once its destroyed 
func _process(_delta):
		var timer = 60
		if destroyed == true:
			timer -= 1
		if timer <= 0:
				queue_free()

