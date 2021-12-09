extends CanvasLayer

var pause = false

onready var Menue = $"VBoxContainer"

onready var Equipment = $"VBoxContainer/HBoxContainer2/Priamry_Slider"
onready var MAP = $"VBoxContainer/HBoxContainer2/Game_map"
onready var Options = $"VBoxContainer/HBoxContainer2/Options" 
onready var Quit_Load = $"VBoxContainer/HBoxContainer2/Quit_Load"

func _process(_delta):
	if (Input.is_action_just_pressed("exit")):
		pause = !pause
		game_pause()
		
func game_pause():
	if pause == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Menue.show()
		if Network.MP == false:
			get_tree().paused = true
		
	if pause == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Menue.hide()
		if Network.MP == false:
			get_tree().paused = false


func _on_equipment_pressed():
	Equipment.show()
	MAP.hide()
	Options.hide()
	Quit_Load.hide()
	
func _on_items_pressed():
	pass 
	
func _on_map_pressed():
	Equipment.hide()
	MAP.show()
	Options.hide()
	Quit_Load.hide()
	
func _on_options_pressed():
	Equipment.hide()
	MAP.hide()
	Options.show()
	Quit_Load.hide()
		
func _on_Quit_Load_pressed():
	Equipment.hide()
	MAP.hide()
	Options.hide()
	Quit_Load.show()
