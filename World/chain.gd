extends Node2D

var Move:bool = false

var RNG = RandomNumberGenerator.new() 

func _process(_delta: float) -> void:
	if $AnimationPlayer.is_playing():
		Move = true
	else:
		Move = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && !Move:
		RNG.randomize()
		if RNG.randi_range(0,1) == 1:
			$AnimationPlayer.play("RESET")
			$SVX.play()
