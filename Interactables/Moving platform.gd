extends Spatial

onready var tween = $Tween

var start_point = Vector3.ZERO
export var end_point = Vector3.ZERO

var speed = 5
var wait_time = 1
var travel_time = 1

func _ready():
	start_point = global_transform.origin
	travel_time = end_point.length() / speed
	tween.interpolate_property(self, "translation", start_point, end_point, travel_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, wait_time)
	tween.interpolate_property(self, "translation", end_point, start_point, travel_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, travel_time + wait_time * 2)
	tween.start()
	
	
