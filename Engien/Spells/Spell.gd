extends Resource

class_name Spell

@export var Name:String =""

@export var icon:Texture2D

@export var Damage:int = 0

@export var damage_Type:Array[Damage_Type]

func get_Name():
	return Name

func get_Icon():
	return icon

func get_Damage():
	return Damage

func get_damage_Type():
	return damage_Type
