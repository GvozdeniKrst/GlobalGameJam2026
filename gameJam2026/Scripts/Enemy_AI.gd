extends CharacterBody2D
var direction = 360
@onready var ray_cast: RayCast2D = $RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$RayCast2D.enabled = true
	velocity.x = direction
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.name == "Player":
			collider.take_damage(10)
			pass
		elif collider.name != "Player":
			direction *= -1
			ray_cast.target_position *= -1
	move_and_slide()
