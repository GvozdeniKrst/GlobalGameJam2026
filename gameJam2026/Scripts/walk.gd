extends State

var sprite: AnimatedSprite2D

func enter():
	if player:
		if not sprite and player.has_node("Sprite"):
			sprite = player.get_node("Sprite") as AnimatedSprite2D
		if sprite:
			sprite.play("walk")
		else:
			push_error("Walk state: sprite not found!")
	else:
		push_error("Walk state: player is null!")

func physics_update(delta):
	if player:
		var dir := Input.get_axis("left", "right")

		if dir == 0:
			state_machine.change_state(state_machine.idle)
			return

		if sprite:
			sprite.flip_h = dir < 0

		player.velocity.x = move_toward(
			player.velocity.x,
			dir * player.MAXSPEED,
			player.ACCELERATION * delta
		)

		if Input.is_action_just_pressed("jump"):
			state_machine.change_state(state_machine.jump)

		if Input.is_action_just_pressed("attack"):
			state_machine.change_state(state_machine.attack)

		if Input.is_action_pressed("below"):
			state_machine.change_state(state_machine.crouch)
