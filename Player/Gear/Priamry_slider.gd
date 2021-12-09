extends VBoxContainer

var ROF = Gear.Primary_rof
var dammage = Gear.Primary_dammage

onready var Rof_Slider = $Rof_Slider
onready var Dammage = $Dammage_Slider

func _ready():
	Global._load_Options()
	Rof_Slider.value = ROF 
	Dammage.value = dammage

func _on_Rof_Slider_value_changed(value):
	Gear.Primary_rof = value 

func _on_Dammage_Slider_value_changed(value):
	Gear.Primary_dammage = value

func _on_HSlider3_value_changed(value):
	pass # Replace with function body.
