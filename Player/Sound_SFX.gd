extends Spatial

onready var Foot_Steps = $Foot_Steps
onready var Jump = $Jump
onready var primary = $Primary

func _process(_delta):
	Foot_Steps.set_volume_db(Global.sound_effec_volume) 
	Jump.set_volume_db(Global.sound_effec_volume) 
	primary.set_volume_db(Global.sound_effec_volume) 
