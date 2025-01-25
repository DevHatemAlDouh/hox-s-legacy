class_name HutrBox
extends Area2D

signal received_damage(damage: int)

@export var health :Health

func _ready() -> void:
	connect("area_entered",_on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	print(hitbox.get_tree())
	if hitbox != null:
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
