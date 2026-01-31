extends CharacterBody2D
var direction = 360
var attack_cooldown = 3.0
var attack_timer = 0
@onready var ray_cast: RayCast2D = $RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	attack_timer -= delta
	$RayCast2D.enabled = true
	velocity.x = direction
	velocity.y += 45
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.name == "Player" and attack_timer <= 0:
			collider.take_damage(1)
			attack_timer = attack_cooldown
			pass
		elif collider.name != "Player":
			direction *= -1
			ray_cast.target_position *= -1
	move_and_slide()
