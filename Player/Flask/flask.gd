extends Control

const Max_Uses = 4

@export var animations: AnimationPlayer

var Current_Uses = 4

func Use():
	if Current_Uses == 4:
		animations.play("3")
		Current_Uses-=1
	elif Current_Uses == 3:
		animations.play("2")
		Current_Uses-=1
	elif Current_Uses == 2:
		animations.play("1")
		Current_Uses-=1
	elif Current_Uses == 1:
		animations.play("0")
		Current_Uses-=1
	elif Current_Uses == 0:
		animations.play("Empty")
		Current_Uses-=1

func full():
	if Current_Uses == 3:
		animations.play_backwards("3")
		Current_Uses-= Max_Uses
	elif Current_Uses == 2:
		animations.play_backwards("2")
		if !animations.is_playing():
			animations.play_backwards("3")
		Current_Uses-= Max_Uses
	elif Current_Uses == 1:
		animations.play_backwards("1")
		if !animations.is_playing():
			animations.play_backwards("2")
			if !animations.is_playing():
				animations.play_backwards("3")
		Current_Uses-= Max_Uses
	elif Current_Uses == 0:
		animations.play("Fill")
		Current_Uses-= Max_Uses
