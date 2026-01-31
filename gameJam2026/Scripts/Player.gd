extends CharacterBody2D

var SPEED = 180 
const GRAVITY = 35
const JUMPFORCE = -900
const MAXHP = 2
var CURRENTHP = MAXHP

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		#$Sprite.play("walk")
		#$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		#$Sprite.play("walk")
		#$Sprite.flip_h = true
	#else:
		#$Sprite.play("idle")
		
	#if not is_on_floor():
		#$Sprite.play("air")
		
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	move_and_slide()
	
	velocity.x = lerp(velocity.x,0.0,0.2)
	
func take_damage(DAMAGETAKEN: int):
	if CURRENTHP <= 0:
		return
		
		CURRENTHP -= DAMAGETAKEN
		print(CURRENTHP)
