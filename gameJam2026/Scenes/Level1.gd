extends Node2D


func _on_door_to_level_2_body_entered(body): 
	get_tree().change_scene_to_file("res://Scenes/Level2.tscn")
	


func _on_red_mask_body_entered(body):
	var orphaned_node = get_node("RedMask")
	remove_child(orphaned_node)
	print("carsick")
	# You can re-add it later
	# add_child(orphaned_node)
