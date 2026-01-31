extends CharacterBody2D

const MAXSPEED := 500
const ACCELERATION = 2000
const GRAVITY := 45
const JUMPFORCE := -1250
const ATTACKFRICTION := 1200

const MAXHP := 2
var CURRENTHP := MAXHP

var ISATTACKING := false

var MASKS = []
var CURRENTMASK
var ISWEARINGMASK = false

func _physics_process(delta):
	handle_input(delta)
	apply_physics(delta)
	handle_platform_fallthrough()
	move_and_slide()
	

func handle_input(delta):
	if ISATTACKING:
		return

	var dir := Input.get_axis("left", "right")
	var TARGETSPEED := dir * MAXSPEED
	#if dir != 0:
		#$Sprite.play("walk")
		#$Sprite.flip_h = dir < 0
	#else:
		#$Sprite.play("idle")

	velocity.x = move_toward(velocity.x, TARGETSPEED, ACCELERATION * delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		# $Sprite.play("jump")

	if Input.is_action_just_pressed("attack"):
		start_attack()


func start_attack():
	ISATTACKING = true
	# $Sprite.play("attack")

func apply_physics(delta):
	if ISATTACKING:
		velocity.x = move_toward(velocity.x, 0, ATTACKFRICTION * delta)

	velocity.y += GRAVITY
	
func _on_animation_finished(anim_name):
	if anim_name == "attack":
		ISATTACKING = false
		# $Sprite.play("idle")

func take_damage(damage: int):
	if CURRENTHP <= 0:
		return

	CURRENTHP -= damage
	print(CURRENTHP)
	
func handle_platform_fallthrough():
	if Input.is_action_pressed("down"):
		set_collision_mask_value(5, false)
	else:
		set_collision_mask_value(5, true)
