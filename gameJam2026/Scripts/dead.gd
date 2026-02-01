extends State

var sprite: AnimatedSprite2D

func enter():
	if player:
		player.velocity = Vector2.ZERO
		if not sprite and player.has_node("Sprite"):
			sprite = player.get_node("Sprite") as AnimatedSprite2D
		if sprite:
			sprite.play("dead")
		else:
			push_error("Dead state: sprite not found!")
	else:
		push_error("Dead state: player is null!")

func physics_update(_delta):
	pass
