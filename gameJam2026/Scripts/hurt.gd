extends State

var sprite: AnimatedSprite2D

func enter():
	if player:
		if not sprite and player.has_node("Sprite"):
			sprite = player.get_node("Sprite") as AnimatedSprite2D
		if sprite:
			sprite.play("hurt")
		else:
			push_error("Hurt state: sprite not found on player!")
	else:
		push_error("Hurt state: player is null!")

func physics_update(delta):
	if player:
		player.velocity.x = move_toward(
			player.velocity.x,
			0,
			player.ATTACKFRICTION * delta
		)
		
func _on_sprite_animation_finished():
	if sprite and sprite.animation == "hurt":
		if player.is_on_floor():
			state_machine.change_state(state_machine.idle)
		else:
			state_machine.change_state(state_machine.jump)
