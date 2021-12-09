extends Area

export var map = "res://Maps/Start_town.tscn"
var location = Vector3.ZERO
var Player_on = false

func _process(_delta):
	if Input.is_action_pressed("Action") and Player_on == true:
		location = self.transform.origin 
		#sets the location varables 
		SaveData.map = map
		SaveData.Location = location
		SaveData.Update_save_varables()
		SaveData._save_Game()
		print("saved game")

func _on_Save_Spot_body_entered(body):
	if body. is_in_group("Player"):
		Player_on = true
		Gear.secondary_Ammo = Gear.secondary_Max_Ammo
		Gear.Armor = Gear.Max_Armor

func _on_Save_Spot_body_exited(body):
	if body. is_in_group("Player"):
		Player_on = false
