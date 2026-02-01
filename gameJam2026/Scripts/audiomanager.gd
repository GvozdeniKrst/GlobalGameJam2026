extends Node

@export var mute: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if not mute:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_music():
	$music.play()
	
func play_title():
	$music2.play()
	
func stop_title():
	$music2.stop()
	
func stop_music():
	$music.stop()
	
func play_ambiance():
	$ambiance.play()
	
func stop_ambiance():
	$ambiance.stop()
	
func play_step() -> void:
	$walk.play()
	
func stop_step() -> void:
	$walk.stop()
	
func play_jump() -> void:
	$jump.play()

func play_land() -> void:
	$land.play()
	
func play_stab() -> void:
	$stab.play()
	
func play_pass() -> void:
	$pass.play()

func play_alert() -> void:
	$alert.play()
	
func play_pickup() -> void:
	$pickup.play()
