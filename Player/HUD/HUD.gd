extends CanvasLayer

onready var Health = $HBoxContainer/left_hud/Health
onready var ammo = $HBoxContainer/right_hud/VBoxContainer2/secondary_ammo

#Hud size
onready var hud_size = $HBoxContainer

#minimap varables
onready var Minimap_Border = $Map
var Border_size = Vector2.ZERO
onready var Viewport_Container = $Map/ViewportContainer
onready var Minimap = $Map/ViewportContainer/Viewport

var minimap_size = OS.get_window_size()

#plaer and cam location varables
onready var Player = get_parent()
onready var cam = $Map/ViewportContainer/Viewport/Camera

func _process(_delta):
	Health.text = 'armor:' + str(Gear.Max_Armor) + "-" + str(Gear.Armor)
	ammo.text = "ammo:" +  str( Gear.secondary_Ammo)
	_Mini_map()
	
	hud_size.set_size(OS.get_window_size())

#updates minimap size
func _Mini_map():
	minimap_size = (OS.get_window_size() / 4)
	Border_size.x = minimap_size.x + 48
	Border_size.y = minimap_size.y + 40
	Minimap_Border.set_size(Border_size)
	Viewport_Container.set_size(minimap_size)
	Minimap.set_size(minimap_size)

#has cam map follow player
func _physics_process(_delta):
	cam.translation.x = Player.get_global_transform().origin.x
	cam.translation.z = Player.get_global_transform().origin.z
	cam.translation.y = Player.get_global_transform().origin.y + 40
