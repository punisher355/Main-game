extends Node

var Save_file = "user://Save.save"

#location var
var Location = Vector3.ZERO
var map = "res://Maps/Start_town.tscn"

#custon player varables
var sel_Body: int = 0
var sel_Head: int = 0
var sel_Larm: int = 0
var sel_Rarm: int = 0
var sel_Headgear: int = 0
var sel_Hair: int = 0

#weapone varables
var Primary_dammage = Gear.Primary_dammage
var Primary_rof = Gear.Primary_rof
#3rd stat

var secondary_Weapone = null

#Health varables
var Max_Armor = Gear.Max_Armor

#currency varables
var Metal_Scrap = Gear.Metal_scrap

#progression varables below

#sets the varables befor saving the game
func Update_save_varables():
	sel_Body = Gear.sel_Body
	sel_Body = Gear.sel_Body
	sel_Head = Gear.sel_Head
	sel_Larm = Gear.sel_Larm
	sel_Rarm = Gear.sel_Rarm
	sel_Hair = Gear.sel_Hair
	
	Primary_dammage = Gear.Primary_dammage
	Primary_rof = Gear.Primary_rof
	#3rd stat
	
	secondary_Weapone = null
	
	Max_Armor = Gear.Max_Armor
	
	#currency varables
	Metal_Scrap = Gear.Metal_scrap

func Update_load_varables():
	
	Gear.Location = Location
	
	Gear.sel_Body = sel_Body
	Gear.sel_Body = sel_Body
	Gear.sel_Head = sel_Head
	Gear.sel_Larm = sel_Larm
	Gear.sel_Rarm = sel_Rarm
	Gear.sel_Hair = sel_Hair
	
	Gear.Primary_dammage = Primary_dammage
	Gear.Primary_rof = Primary_rof
	#3rd stat
	
	secondary_Weapone = null
	
	Gear.Max_Armor = Max_Armor
	
	#currency varables
	Gear.Metal_scrap = Metal_Scrap
	
func _save_Game():
	var file = File.new()
	file.open(Save_file, File.WRITE)
	
	#loction varables 
	file.store_var(Location)
	file.store_var(map)
	
	
	#custom player varables
	file.store_var(sel_Body)
	file.store_var(sel_Head)
	file.store_var(sel_Larm)
	file.store_var(sel_Rarm)
	file.store_var(sel_Headgear)
	file.store_var(sel_Hair)
	
	#save the Weapone values
	file.store_var(Primary_dammage)
	file.store_var(Primary_rof)
	#file.store_var(3rd stat)
	
	file.store_var(secondary_Weapone)
	
	file.store_var(Max_Armor)
	
	#currency varables
	file.store_var(Metal_Scrap)
	
	#progression varables below
	
	file.close()
	print("Game saved")

func _load_Game():
	var file = File.new()
	if file.file_exists(Save_file):
		file.open(Save_file, File.READ)
		
		#loction varables
		Location = file.get_var()
		map = file.get_var()
		
		#custom player varables
		sel_Body = file.get_var()
		sel_Head = file.get_var()
		sel_Larm = file.get_var()
		sel_Rarm = file.get_var()
		sel_Headgear = file.get_var()
		sel_Hair = file.get_var()
		
		#Load the Weapone values
		Primary_dammage = file.get_var()
		Primary_rof = file.get_var()
		#load 3rd stat
		
		secondary_Weapone = file.get_var()
		
		Max_Armor = file.get_var()
		
		#currency varables
		Metal_Scrap = file.get_var()
		
		#progression varables below
		
		file.close()
	print("Game loaded")
