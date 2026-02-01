extends Node2D


func _on_door_to_level_2_body_entered(body): 
	AudioController.stop_step()
	AudioController.stop_music()
	AudioController.stop_ambiance()
	get_tree().change_scene_to_file("res://Scenes/level_transition.tscn")
	AudioController.play_pass()
	


func _on_red_mask_body_entered(body):
	var orphaned_node = get_node("RedMask")
	remove_child(orphaned_node)
	AudioController.play_pickup()
	
	# You can re-add it later
	# add_child(orphaned_node)
