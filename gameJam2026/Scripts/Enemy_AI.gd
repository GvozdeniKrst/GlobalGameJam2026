extends CharacterBody2D

@onready var ray_cast: RayCast2D = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), Vector2(50, 100))
	var result = space_state.intersect_ray(query)
	
	if result:
		print(result.collider)


func _draw():
	var start_point = Vector2.ZERO
	var end_point = ray_cast.target_position
	var color = Color(1, 0, 0) # Red if not colliding
	if ray_cast.is_colliding():
		end_point = ray_cast.get_collision_point()
		color = Color(0, 1, 0) # Green if colliding

	# Draw the line
	draw_line(start_point, end_point, color, 2.0)
	
	# Draw a point at the end
	if ray_cast.is_colliding():
		draw_circle(end_point, 4.0, Color(0, 1, 0))
