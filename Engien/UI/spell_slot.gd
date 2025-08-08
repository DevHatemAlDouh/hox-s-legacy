extends Node2D


@onready var spell = $Spell

func Set_texture(texture):
	spell.texture = texture
