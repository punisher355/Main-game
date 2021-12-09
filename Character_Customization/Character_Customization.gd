extends Spatial

#preload all the parts
var Body_preload = PreloadMesh.Body_preload
var Head_preload = PreloadMesh.Head_preload
var Larm_preload = PreloadMesh.Larm_preload
var Rarm_preload = PreloadMesh.Rarm_preload
var Headgear_preload = PreloadMesh.Headgear_preload
var Hair_Preload = PreloadMesh.Hair_Preload
var Skintone_Preload = PreloadMesh.Skintone

#sets the parts as varables
onready var Body = $Animated_Character/Body/Body
onready var Head = $Animated_Character/Head/Head
onready var Larm = $Animated_Character/armLeft/ArmLeft
onready var Rarm = $Animated_Character/armRight/ArmRight
onready var Headgear = $Animated_Character/Head/Headgear
onready var Hair = $Animated_Character/Head/Hair

# selected part
var sel_Body: int = 0
var sel_Head: int = 0
var sel_Larm: int = 0
var sel_Rarm: int = 0
var sel_Headgear: int = 0
var sel_Hair: int = 0
var sel_Skintone: int = 0

#anamation varables
onready var anm = $AnimationPlayer

func _ready():
	Body.mesh = Body_preload [sel_Body]
	Head.mesh = Head_preload [sel_Head]
	Larm.mesh = Larm_preload [sel_Larm]
	Rarm.mesh = Rarm_preload [sel_Rarm]
	Headgear.mesh = Headgear_preload [sel_Headgear]
	
	Head.set_surface_material(0,Skintone_Preload [sel_Skintone])
	
	anm.play("KayKit Animated Character|Walk")
	
func _on_Arm_pressed():
	sel_Larm = (sel_Larm + 1) % Larm_preload.size()
	sel_Rarm = (sel_Rarm + 1) % Rarm_preload.size()
	Larm.mesh = Larm_preload [sel_Larm]
	Rarm.mesh = Rarm_preload [sel_Rarm]

func _on_Body_pressed():
	sel_Body = (sel_Body + 1) % Body_preload.size()
	Body.mesh = Body_preload [sel_Body]
	
func _on_Head_pressed():
	sel_Head = (sel_Head + 1) % Head_preload.size()
	Head.mesh = Head_preload [sel_Head]

func _on_hair_pressed():
	sel_Headgear = (sel_Headgear + 1) % Headgear_preload.size()
	Headgear.mesh = Headgear_preload [sel_Headgear]

func _on_Skin_Tone_pressed():
	sel_Skintone = (sel_Skintone + 1) % Skintone_Preload.size()
	Head.set_surface_material(0,Skintone_Preload [sel_Skintone])
	#Head.material_override = Skintone_Preload [sel_Skintone]

func _on_Play_pressed():
	Gear.sel_Body = sel_Body
	Gear.sel_Body = sel_Body
	Gear.sel_Head = sel_Head
	Gear.sel_Larm = sel_Larm
	Gear.sel_Rarm = sel_Rarm
	Gear.sel_Hair = sel_Hair
	Gear.sel_Skintone = sel_Skintone
	get_tree().change_scene("res://Maps/Start_room.tscn")
