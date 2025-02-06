class_name HutrBox
extends Area2D

signal received_damage(damage: int)

@export var health :Health

func _ready() -> void:
	connect("area_entered",_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HitBox:
		var hitbox: HitBox = area
		if hitbox != null:
			health.health -= hitbox.damage
			received_damage.emit(hitbox.damage)
