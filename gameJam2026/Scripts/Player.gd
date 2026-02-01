extends CharacterBody2D

const MAXSPEED := 500
const ACCELERATION := 2000
const GRAVITY := 45
const JUMPFORCE := -1250
const ATTACKFRICTION := 1200

const MAXHP := 2
var current_hp := MAXHP

@onready var state_machine = $StateMachine
@onready var sprite = $Sprite

func _physics_process(delta):
	velocity.y += GRAVITY
	state_machine.physics_update(delta)
	move_and_slide()

func _unhandled_input(event):
	state_machine.handle_input(event)

func take_damage(amount: int):
	if current_hp <= 0:
		return

	current_hp -= amount
	if current_hp <= 0:
		state_machine.change_state($StateMachine/Dead)
