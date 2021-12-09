extends Node

#primary weapone
var Primary = preload('res://Player/Gear/Primary_Shot.tscn')
var Primary_rof = 40
var Primary_dammage = 1

#secondary weapone
var secondary = preload('res://Player/Gear/Primary_Shot.tscn')
var secondary_rof = 40
var secondary_dammage = 3
var secondary_Max_Ammo = 10
var secondary_Ammo = secondary_Max_Ammo

#Health varables
var Max_Armor = 100
var Armor = Max_Armor

#custon player varables
var sel_Body: int = 0
var sel_Head: int = 0
var sel_Larm: int = 0
var sel_Rarm: int = 0
var sel_Headgear: int = 0
var sel_Hair: int = 0
var sel_Skintone: int = 0

#location var
var Location = Vector3(0,5.805,0)

#currency varables
var Metal_scrap = 0
