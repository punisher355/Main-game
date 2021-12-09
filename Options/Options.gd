extends VBoxContainer

# settign the nodes as varables
onready var Window = $Window/window 
onready var Inverted_mouse = $Inverted_Mouse/inverted_mouse
onready var Resolution = $Resolution/resolution
onready var Music_Volume = $Music_Volume/Music_Volume
onready var sound_effec_volume = $sound_effec_volume/sound_effec_volume
onready var Voice_volume = $Voice_volume/Voice_volume
onready var Mouse_Sensitivity = $Mouse_Sensitivity/mouse_sensitivity

#resolution varables 
var RESOLUTION_SETTINGS = [Vector2(1920, 1080), Vector2(1600, 900), Vector2(1366, 768),
Vector2(1280, 720), Vector2(1024, 600)]
var resolution:Vector2

func _ready():
	add_items()
	Global._load_Options()
	# Sets the games settings from save file
	resolution = Global.resolution
	set_resolution()
	set_display()
 
# displays the mouse inverson and window settings
func update_Option_text(): 
	Window.select (Global.Display)
	
	if Global.mouse_inversion == true:
		Inverted_mouse.text = "INVERTED Y"
	elif Global.mouse_inversion == false:
		Inverted_mouse.text = "NORMAL"

	Music_Volume.value = Global.Music_Volume
	sound_effec_volume.value = Global.sound_effec_volume
	Voice_volume.value = Global.Voice_volume
	Mouse_Sensitivity.value = Global.mouse_sensitivity * 10

	Resolution.select(RESOLUTION_SETTINGS.find(OS.get_window_size()))
	
	Global._save_Options()
	
func add_items():
	# adds the resolutions to the resolution select
	for x in RESOLUTION_SETTINGS.size():
		var v = RESOLUTION_SETTINGS[x]
		Resolution.add_item(str(v.x) + " x " + str(v.y), x)
	
	#adds the display to the wundow select 
	Window.add_item("WINDOWED")
	Window.add_item("WINDOWED BORDERLESS")
	Window.add_item("FULL SCREEN")

#applies the selected resolution to the game
func _on_resolution_item_selected(id):
	resolution = RESOLUTION_SETTINGS[id]
	set_resolution()

func set_resolution():
	OS.set_window_size(resolution)
	Global.resolution = resolution
	update_Option_text()

#window toggle or fullscreen
func _on_window_item_selected(id):
	Global.Display = id
	set_display()

func set_display():
	if Global.Display == 0:
		OS.set_borderless_window(false)
		OS.window_fullscreen = false
	elif Global.Display == 1:
		OS.set_borderless_window(true)
		OS.window_fullscreen = false
	elif Global.Display == 2:
		OS.set_borderless_window(false)
		OS.window_fullscreen = true
	update_Option_text()
	
# volume controlls
func _on_Music_Volume_value_changed(value):
	Global.Music_Volume = value
	update_Option_text()

func _on_sound_effec_volume_value_changed(value):
	Global.sound_effec_volume = value
	update_Option_text()

func _on_Voice_volume_value_changed(value):
	Global.Voice_volume = value
	update_Option_text()

# inverted mouse check box
func _on_inverted_mouse_pressed():
	Global.mouse_inversion = !Global.mouse_inversion
	update_Option_text()

# change mouse Sensitivity
func _on_mouse_sensitivity_value_changed(value):
	Global.mouse_sensitivity = value * .1
	update_Option_text()
