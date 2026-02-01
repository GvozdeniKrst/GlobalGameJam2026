extends State

var sprite: AnimatedSprite2D

func enter():
	if player:
		player.velocity.y = player.JUMPFORCE
		if not sprite and player.has_node("Sprite"):
			sprite = player.get_node("Sprite") as AnimatedSprite2D
		if sprite:
			AudioController.play_jump()
			sprite.play("jump")
		else:
			push_error("Jump state: sprite not found!")
	else:
		push_error("Jump state: player is null!")

func physics_update(delta):
	if player:
		var dir := Input.get_axis("left", "right")
		
		if sprite:
			if dir != 0:
				sprite.flip_h = dir < 0
			
		player.velocity.x = move_toward(
			player.velocity.x,
			dir * player.MAXSPEED,
			player.ACCELERATION * delta
		)

		if player.is_on_floor():
			if dir == 0 and player.velocity.y < -0.5:
				pass
			else:
				AudioController.play_land()
				state_machine.change_state(state_machine.walk)
		
				
		
