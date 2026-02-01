extends CharacterBody2D
var direction = 360
var attack_cooldown = 3.0
var attack_timer = 0
var push_timer = 2
var pushed = false
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var my_sprite = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RayCast2D.enabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(velocity.x != 0):
		my_sprite.play("Walk")
	else:
		my_sprite.play("Idle")
	my_sprite.flip_h = direction < 0
	attack_timer -= delta
	if pushed == true:
		push_timer -= delta
		my_sprite.self_modulate = Color(1,0,0)
	else:
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
		$RayCast2D.enabled = true
		push_timer = 2
		pushed = false
		my_sprite.self_modulate =  Color(1, 1, 1)
	handle_platform_fallthrough()
	move_and_slide()

func get_pushed_back():
	velocity.x = 0
	$RayCast2D.enabled = false
	pushed = true

func handle_platform_fallthrough():
	set_collision_mask_value(5, true)
