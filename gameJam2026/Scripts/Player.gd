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
@onready var portrait_sprite: Sprite2D = $Camera2D/Sprite2D
@onready var timer_node: Timer = $Timer

func _ready() -> void:
	portrait_sprite.frame = 0
	
func handle_platform_fallthrough():
	if Input.is_action_pressed("below"):
		set_collision_mask_value(5, false)
		print(get_collision_mask_value(5))
	else:
		set_collision_mask_value(5, true)

func _physics_process(delta):
	velocity.y += GRAVITY
	state_machine.physics_update(delta)
	handle_platform_fallthrough()
	move_and_slide()

func _unhandled_input(event):
	state_machine.handle_input(event)

func take_damage(amount: int):
	if current_hp <= 0:
		return
	
	
	current_hp -= amount
	
	portrait_sprite.frame = 2
	# if mask is equipped, swap to 5
	timer_node.start()
	if current_hp <= 0:
		state_machine.change_state($StateMachine/Dead)


func _on_timer_timeout() -> void:
	portrait_sprite.frame = 1 # or 4 if wearing mask
