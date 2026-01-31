extends CharacterBody2D

@onready var ray_cast: RayCast2D = $RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$RayCast2D.enabled = true
	
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.name != "JohnEnemy":
			print("hi")
		else:
			print("KILL HIM")
