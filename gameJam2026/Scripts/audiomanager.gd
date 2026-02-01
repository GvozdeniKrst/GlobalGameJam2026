extends Node

var state_machine : Node2D

@onready var walk : AudioStreamPlayer = $walk
@onready var jump : AudioStreamPlayer = $jump
@onready var land : AudioStreamPlayer = $land
@onready var stab : AudioStreamPlayer = $stab
@onready var alert : AudioStreamPlayer = $alert

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if walk:
		print("we good")
	pass
