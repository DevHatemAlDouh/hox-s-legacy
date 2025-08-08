extends CanvasLayer

var slot1
var slot2
var slot3

func _ready() -> void:
	slot1 = $"Spell slot"
	slot2 = $"Spell slot2"
	slot3 = $"Spell slot3"

func spell_slots(spell,slot:int):
	if slot == 1:
		slot1.Set_texture(spell)
	if slot == 2:
		slot2.Set_texture(spell)
	if slot == 3:
		slot3.Set_texture(spell)
