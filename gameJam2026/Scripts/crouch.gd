extends State

var sprite: AnimatedSprite2D

func enter():
	if player:
		player.velocity.x = 0
		if not sprite and player.has_node("Sprite"):
			sprite = player.get_node("Sprite") as AnimatedSprite2D
		if sprite:
			sprite.play("crouch")
		else:
			push_error("Crouch state: sprite not found!")
	else:
		push_error("Crouch state: player is null!")

func physics_update(_delta):
	if player:
		player.velocity.x = move_toward(player.velocity.x, 0, player.ACCELERATION)

		if not Input.is_action_pressed("below"):
			state_machine.change_state(state_machine.idle)

		if Input.is_action_just_pressed("attack"):
			if player.hasMask:
				state_machine.change_state(state_machine.attack)
