extends Node

var resolution = Vector2(1024, 600)
var Display = 0
var Music_Volume = -20
var sound_effec_volume = -20
var Voice_volume = -20
var mouse_inversion = true
var mouse_sensitivity = .3

#options save file location
var options_file = "user://Options.save"

func _save_Options():
	var file = File.new()
	file.open(options_file, File.WRITE)
	#save the Options values
	file.store_var(resolution)
	file.store_var(Display)
	file.store_var(Music_Volume)
	file.store_var(sound_effec_volume)
	file.store_var(Voice_volume)
	file.store_var(mouse_inversion)
	file.store_var(mouse_sensitivity)
	file.close()
	print("options saved")
	
func _load_Options():
	var file = File.new()
	if file.file_exists(options_file):
		file.open(options_file, File.READ)
		#Load the Options values
		resolution = file.get_var()
		Display = file.get_var()
		Music_Volume = file.get_var()
		sound_effec_volume = file.get_var()
		Voice_volume = file.get_var()
		mouse_inversion = file.get_var()
		mouse_sensitivity = file.get_var()
		file.close()
	print("Options loaded")
