extends State

var sprite: AnimatedSprite2D
var area: Area2D

func enter():
	AudioController.play_step()
	if player:
		if not sprite and player.has_node("Sprite"):
			sprite = player.get_node("Sprite") as AnimatedSprite2D
			area = player.get_node("Sprite/Area2D") as Area2D

		if sprite:
			sprite.play("walk")
		else:
			push_error("Walk state: sprite not found!")
	else:
		push_error("Walk state: player is null!")

func physics_update(delta):
	if player:
		var dir := Input.get_axis("left", "right")

		if dir == 0 and player.is_on_floor():
			AudioController.stop_step()
			state_machine.change_state(state_machine.idle)
			return

		if sprite:
			if dir != 0:
				
				sprite.flip_h = dir < 0
				area.scale.x = -1 if dir < 0 else 1

		player.velocity.x = move_toward(
			player.velocity.x,
			dir * player.MAXSPEED,
			player.ACCELERATION * delta
		)

		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			AudioController.stop_step()
			state_machine.change_state(state_machine.jump)

		if Input.is_action_just_pressed("attack"):
			AudioController.stop_step()
			state_machine.change_state(state_machine.attack)

		if Input.is_action_pressed("below"):
			AudioController.stop_step()
			state_machine.change_state(state_machine.crouch)
