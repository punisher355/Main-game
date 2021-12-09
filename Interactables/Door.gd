extends KinematicBody

var Player_near = false
var open = false

onready var tween = $Tween

export var Y = false

var start_point = Vector3.ZERO
var end_point = Vector3.ZERO

var speed = 1
var wait_time = 1

onready var sound = $AudioStreamPlayer

func _ready():
	start_point = global_transform.origin
	end_point = start_point
	if Y == true:
		end_point.z -= 5
	else:
		end_point.x -= 5

	tween.interpolate_property(self, "translation", start_point, end_point, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, wait_time)
		
func _process(_delta):
	if Input.is_action_pressed("Action") and Player_near == true:
		if open == false:
			open = true
			_Open()

func _Open():
	sound.set_volume_db(Global.sound_effec_volume)
	sound.play()
	tween.start()

func _on_Area_body_entered(body):
	if body. is_in_group("Player"):
		Player_near = true

func _on_Area_body_exited(body):
	if body. is_in_group("Player"):
		Player_near = false
