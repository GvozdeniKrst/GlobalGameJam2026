extends CharacterBody2D

<<<<<<< Updated upstream
const MAXSPEED := 700
const ACCELERATION = 2000
=======
const MAXSPEED := 500
const ACCELERATION := 2000
>>>>>>> Stashed changes
const GRAVITY := 45
const JUMPFORCE := -1250
const ATTACKFRICTION := 1200

const MAXHP := 2
var current_hp := MAXHP

@onready var sprite = $Sprite
@onready var state_machine = $StateMachine

func _physics_process(delta):
	velocity.y += GRAVITY
	state_machine.physics_update(delta)
	move_and_slide()

func _unhandled_input(event):
	state_machine.handle_input(event)

func take_damage(damage: int):
	if current_hp <= 0:
		return

	current_hp -= damage
	if current_hp <= 0:
		state_machine.change_state($StateMachine/Dead)
