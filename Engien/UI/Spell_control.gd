@tool
extends Control

const SPRITE_SIZE = Vector2(32,32)

@export var BG_Color: Color
@export var iner_Color:Color		

@export var outer_radius:int = 256
@export var inner_radius:int = 64
@export var line_width:int = 4

@export var Options : Array[Spell]

var Spells = []

func _draw() -> void:
	var offset = SPRITE_SIZE / -2
	
	draw_circle(Vector2.ZERO,outer_radius,BG_Color)
	draw_arc(Vector2.ZERO,inner_radius,0,TAU,64,iner_Color,line_width,true)
	
	for i in range(len(Options)):
		var rads = TAU * i / len(Options)
		var point = Vector2.from_angle(rads)
		draw_line(
			point * inner_radius,
			point * outer_radius,
			iner_Color,
			line_width,
			true
		)
	
	for i in range(len(Options)):
		var start_rads = (TAU * i-1)/ len(Options)
		var end_rads = (TAU * i)/ len(Options)
		var min_rads = (start_rads + end_rads)/.4 * -1
		var radius_min = (inner_radius + outer_radius) - 75
		
		var draw_pos = radius_min * Vector2.from_angle(min_rads) + offset
		var texture_to_apply: Texture2D = Options[i].get_Icon()
		if texture_to_apply != null:
			draw_texture_rect_region(
				texture_to_apply,
				Rect2(draw_pos,SPRITE_SIZE),
				Rect2(Vector2.ZERO, SPRITE_SIZE)
				)
func _process(delta: float) -> void:
	queue_redraw()

func ADD(spell):
	Spells.append(spell)
	for i in range(len(Options)):
		if Options[i].get_Name() == "null":
			Options.pop_at(i)
			Options.insert(i,spell)
			break
	
func Size():
	return Spells.size()
