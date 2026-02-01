extends CharacterBody2D
var direction = 260
var attack_cooldown = 2.0
var attack_timer = 0
var push_timer = 2
var pushed = false
var notice_player_timer = 30
var notice_player = false;
var chasing_player = false;
var chasing_player_timer = 600
var turning_around = false;
var turn_around_timer = 90
var HP = 1

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var my_sprite = $Sprite2D
@onready var ray_cast_platform = $PlatformFind
@onready var exclamation_mark = $ExclaimationMark
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RayCast2D.enabled = true
	exclamation_mark.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	my_sprite.flip_h = direction < 0
	attack_timer -= delta
	if pushed == true:
		push_timer -= delta
		my_sprite.self_modulate = Color(1,0,0)
	else:
		if !turning_around:
			velocity.x = direction
	if(velocity.x != 0):
		my_sprite.play("Walk")
	else:
		if push_timer <= 1.5 and my_sprite.animation_finished:
			my_sprite.play("Idle")
	velocity.y += 45
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.name == "Player" and attack_timer <= 0 && get_parent().get_node("Player").hiding == false:
			if !chasing_player:
				AudioController.play_alert()
				notice_player = true;
			chasing_player = true;
			notice_player_timer = 30
			chasing_player_timer = 600
			if !notice_player:
				my_sprite.play("Attack")
				collider.take_damage(1)
				attack_timer = attack_cooldown
				get_pushed_back()
		elif collider.name != "Player":
			direction *= -1
			ray_cast.target_position *= -1
			ray_cast_platform.target_position.x *= -1
			push_timer = 2
			pushed = false
	if not ray_cast_platform.is_colliding():
		direction *= -1
		ray_cast.target_position *= -1
		ray_cast_platform.target_position.x *= -1
			
		if !turning_around:
			turning_around = true
			if chasing_player:
				turn_around_timer = 45
			else:
				turn_around_timer = 90
		
		pass
	if push_timer <= 0:
		$RayCast2D.enabled = true
		push_timer = 2
		pushed = false
		my_sprite.self_modulate =  Color(1, 1, 1)
		
	# Enemy Stops on noticing player
	if notice_player:
		notice_player_timer -= 1
		direction = 0
		exclamation_mark.visible = true
		
	
	if notice_player_timer <= 0:
		notice_player = false
		chasing_player = true
		exclamation_mark.visible = false
		
	# Enemy chases player faster than walking speed
	if chasing_player and !notice_player:
		if direction < 0:
			direction = -400
		else:
			direction = 400
		chasing_player_timer -= 1
	elif !notice_player and !turning_around: 
		if direction < 0:
			direction = -260
		else:
			direction = 260

	# Enemy stops when turning around
	if turning_around:
		velocity.x = 0
		turn_around_timer -= 1
	
	if turn_around_timer <= 0:
		turning_around = false
	
	if chasing_player_timer <= 0:
		chasing_player = false;
	
	handle_platform_fallthrough()
	move_and_slide()

func get_pushed_back():
	velocity.x = 0
	$RayCast2D.enabled = false
	pushed = true

func handle_platform_fallthrough():
	set_collision_mask_value(5, true)

func take_damage(amount: int):
	HP -= amount
	if HP == 0:
		die()
	
func die():
	queue_free()
