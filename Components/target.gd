extends Node2D

@export var target : Sprite2D
@export var animation :AnimationPlayer

func Targeted(targeted :bool)-> void:
	if target.visible and !targeted:
		animation.play_backwards("idel")
	elif !target.visible and targeted:
		animation.play("idel")
