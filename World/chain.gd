extends Node2D

var Move:bool = false

func _process(_delta: float) -> void:
	if $AnimationPlayer.is_playing():
		Move = true
	else:
		Move = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("player") && !Move:
		$AnimationPlayer.play("RESET")
		$SVX.play()
