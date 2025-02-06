extends Node2D

@export var MAX_HP : float
var HP: float   
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func birth():
	HP = MAX_HP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
