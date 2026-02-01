extends Node

var current_state

@onready var idle   = $Idle
@onready var walk   = $Walk
@onready var jump   = $Jump
@onready var crouch = $Crouch
@onready var attack = $Attack
@onready var dead   = $Dead

func _ready():
	# Set initial state in code
	var initial_state = idle
	change_state(initial_state)

func change_state(new_state):
	if current_state:
		current_state.exit()

	current_state = new_state
	# Pass references to the state
	current_state.player = get_parent()
	current_state.state_machine = self
	current_state.enter()

func handle_input(event):
	if current_state:
		current_state.handle_input(event)

func physics_update(delta):
	if current_state:
		current_state.physics_update(delta)
