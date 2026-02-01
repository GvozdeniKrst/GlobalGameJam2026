extends Node2D

func _on_red_mask_body_entered(body):
	var orphaned_node = get_node("RedMask")
	remove_child(orphaned_node)
	AudioController.play_pickup()
	print("carsick")
	


func _on_door_to_level_3_body_entered(body): 
	AudioController.stop_step()
	AudioController.stop_ambiance()
	AudioController.stop_music()
	AudioController.play_pass()
	get_tree().change_scene_to_file("res://Scenes/EndScreen.tscn")
