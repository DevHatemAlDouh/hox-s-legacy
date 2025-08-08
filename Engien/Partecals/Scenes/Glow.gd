extends Node2D

@export var color: Color 

func _process(delta: float) -> void:
	$CPUParticles2D.color = color
	$AnimationPlayer.play("Smit")
