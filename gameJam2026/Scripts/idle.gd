extends State

var sprite: AnimatedSprite2D

func enter():
	if player:
		# Try to get the sprite node if we haven't already
		if not sprite and player.has_node("Sprite"):
			sprite = player.get_node("Sprite") as AnimatedSprite2D
		
		if sprite:
			sprite.play("idle")
		else:
			push_error("Idle state: 'sprite' node not found on player!")
	else:
		push_error("Idle state: 'player' is null!")

func handle_input(_event):
	var dir := Input.get_axis("left", "right")

	if Input.is_action_just_pressed("attack"):
		state_machine.change_state(state_machine.get_node("Attack"))
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state(state_machine.get_node("Jump"))
	elif Input.is_action_pressed("below"):
		state_machine.change_state(state_machine.get_node("Crouch"))
	elif dir != 0:
		state_machine.change_state(state_machine.get_node("Walk"))

func physics_update(delta):
	if player:
		player.velocity.x = move_toward(
			player.velocity.x,
			0,
			player.ACCELERATION * delta
		)
