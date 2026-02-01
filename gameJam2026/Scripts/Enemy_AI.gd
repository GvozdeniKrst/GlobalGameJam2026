extends CharacterBody2D
var direction = 360
var attack_cooldown = 3.0
var attack_timer = 0
var push_timer = 2
var pushed = false
@onready var ray_cast: RayCast2D = $RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RayCast2D.enabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	attack_timer -= delta
	if pushed == true:
		push_timer -= delta
	velocity.x = direction
	velocity.y += 45
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.name == "Player" and attack_timer <= 0:
			collider.take_damage(1)
			attack_timer = attack_cooldown
			get_pushed_back()
		elif collider.name != "Player":
			direction *= -1
			ray_cast.target_position *= -1
			push_timer = 2
			pushed = false
	if push_timer <= 0:
		direction = 360
		$RayCast2D.enabled = true
		push_timer = 2
		pushed = false
	move_and_slide()

func get_pushed_back():
	direction = 0
	$RayCast2D.enabled = false
	pushed = true
