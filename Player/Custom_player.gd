extends Skeleton

onready var Body = $Body/Body
onready var Head = $Head/Head
onready var Larm = $armLeft/ArmLeft
onready var Rarm = $armRight/ArmRight
onready var Headgear = $Head/Headgear
onready var Hair = $Head/Hair

func _ready():
	Body.mesh = PreloadMesh.Body_preload [Gear.sel_Body]
	Head.mesh = PreloadMesh.Head_preload [Gear.sel_Head]
	Larm.mesh = PreloadMesh.Larm_preload [Gear.sel_Larm]
	Rarm.mesh = PreloadMesh.Rarm_preload [Gear.sel_Rarm]
	Headgear.mesh = PreloadMesh.Headgear_preload [Gear.sel_Headgear]  
	Hair.mesh = PreloadMesh.Hair_Preload [Gear.sel_Hair]
