extends KinematicBody

#Movement varables
var acceleration  = 1
export var max_speed = 25
var velocity = Vector3()
var Movement = Vector3()
var snap = Vector3.DOWN
#slide on slope
var slide = true

#gravity variables
export var gravity = .8
export var jump_hight = 25

#cam varables  
var mouse_sensitivity = Global.mouse_sensitivity
var mouse_inversion = Global.mouse_inversion
var camera_change = Vector2()
var camera_angle = 0

#animation varables
onready var anim = $Boddy/Node/AnimationTree.get("parameters/playback")
var animation = Vector2.ZERO

#sound varables
onready var step_timer = $Sound_SFX/Foot_Step
onready var Foot_Steps = $Sound_SFX/Foot_Steps
onready var Jump_sound = $Sound_SFX/Jump

#sets the chiled nodes as varables
onready var Torso = $Boddy
onready var Head = $Boddy/Head
onready var Weapone = $Boddy/right_hand

# weapone varables
onready var Primary_sound = $Sound_SFX/Primary
var Primary_countdown = 0
var secondary_countdown = 0

func _process(_delta):
	#checks if varables change
	mouse_sensitivity = Global.mouse_sensitivity
	mouse_inversion = Global.mouse_inversion
	
	#calls other functions 
	Camera()
	Priamry_fire()
	Secondary_fire()
	Animation()
	movement()

func _input(event):  
	if event is InputEventMouseMotion:
		camera_change = event.relative

#movement function
func movement():
	#sets the WASD inputs to movement varabels and sets the cam direction to always face foward
	Movement.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	Movement.z = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	#JacklRabbit from discord created the below line 
	Movement = Movement.rotated(Vector3.UP,deg2rad(Torso.get_rotation_degrees().y))
	Movement = Movement.normalized()
	
	#sets gravity to the player
	velocity.y -= gravity
	
	#creates tempary velocity varables for x and z
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	# multiplies the movement times the max speed
	var moving = Movement * max_speed 
	
	#sets the acceleration rate for moveing and slowing down
	if Movement.dot(temp_velocity) > 0:
		acceleration = .2
	else:
		acceleration = .6
	
	#increases or decreases player speed gradualy 
	temp_velocity = temp_velocity.linear_interpolate(moving, acceleration)
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	
	#sets the velocity varable as the palyers movement move  
	velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, slide)
	
	#allows jumping
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity.y = jump_hight
		snap = Vector3.ZERO
	else:
		snap = Vector3.DOWN

#Camera function
func Camera(): 
	Torso.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))
	if mouse_inversion == true:
		var change = camera_change.y * mouse_sensitivity
		if change + camera_angle < 0 and change + camera_angle > -90:
			Head.rotate_x(deg2rad(change))
			camera_angle += change
	elif mouse_inversion == false:
		var change = -camera_change.y * mouse_sensitivity
		if change + camera_angle < 0 and change + camera_angle > -90:
			Head.rotate_x(deg2rad(change))
			camera_angle += change
	camera_change = Vector2()

#Primary attacking function
func Priamry_fire():
	#count up towards next shot
	Primary_countdown += 1
	if Input.is_action_pressed("Primary") and Primary_countdown >= Gear.Primary_rof:
		Primary_countdown = 0
		var Shot = Gear.Primary.instance()
		Shot.start(Weapone.global_transform)
		get_parent() .add_child(Shot)
		Pew()
	
#Secondary Shooting function
func Secondary_fire():
	#count up towards next shot
	secondary_countdown += 1
	if Input.is_action_just_released("Secondary") and secondary_countdown >= Gear.secondary_rof and Gear.secondary_Ammo > 0:
		Gear.secondary_Ammo -= 1
		secondary_countdown = 0
		var Shot = Gear.secondary.instance()
		Shot.start(Weapone.global_transform)
		get_parent() .add_child(Shot)
		Pew()

# palys a noise when fireing Primary
func Pew():
	var Pitch = RandomNumberGenerator.new()
	Pitch.randomize()
	Pitch = Pitch.randi_range(9,12)
	Pitch *= 0.1 
	Primary_sound.pitch_scale = Pitch
	Primary_sound.play()

#playes the Animation
func Animation():
	#movement animation
	animation.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	animation.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	anim.travel("Idle") 
	if animation != Vector2.ZERO:
		anim.travel("Walk") 
		if step_timer.time_left <= 0 and is_on_floor():
			var Pitch = RandomNumberGenerator.new()
			Pitch.randomize()
			Pitch = Pitch.randi_range(9,12)
			Pitch *= 0.1 
			Foot_Steps.pitch_scale = Pitch
			Foot_Steps.play()
			step_timer.start(0.5)

	#jumping anamation
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		anim.travel("Jump")
		Jump_sound.play()
	
	#attacking anamation
	if Input.is_action_pressed("Primary"):
		anim.travel("Attack_Start")
	if Input.is_action_just_released("Primary"):
		anim.travel("Attack_End")

# checks What palyer is steping on 
func _on_Area_body_entered(body):
	if body. is_in_group("Moving_platform"):
		slide = false
	else:
		slide = true
