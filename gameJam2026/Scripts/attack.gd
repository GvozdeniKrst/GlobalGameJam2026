extends State

var sprite: AnimatedSprite2D
var animation: AnimationPlayer

func enter():
	if player:
		if not sprite and player.has_node("Sprite"):
			sprite = player.get_node("Sprite") as AnimatedSprite2D
			animation = player.get_node("AnimationPlayer") as AnimationPlayer
		if sprite:
			sprite.play("attack")
			animation.play("attack")
		else:
			push_error("Attack state: sprite not found on player!")
	else:
		push_error("Attack state: player is null!")

func physics_update(delta):
	if player:
		player.velocity.x = move_toward(
			player.velocity.x,
			0,
			player.ATTACKFRICTION * delta
		)

func _on_sprite_animation_finished():
	if sprite and sprite.animation == "attack":
		if player.is_on_floor():
			state_machine.change_state(state_machine.idle)
		else:
			state_machine.change_state(state_machine.jump)
