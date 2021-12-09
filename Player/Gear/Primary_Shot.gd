extends Area

var speed = .8 #vspeed or round make changabe for equipment
var velocity = Vector3()

var timer = 0

var dammage = Gear.Primary_dammage

func start(xform):
	transform = xform
	velocity = +transform.basis.z * speed

func _process(_delta):
	transform.origin -= velocity 
	timer += 1
	if timer >= 60:
		queue_free()
		

func _on_Primary_body_entered(body):
	if body. is_in_group("enemy"):
		body.OnHit(dammage)
	if body. is_in_group("destructible"):
		body.OnHit(dammage)
	queue_free()
