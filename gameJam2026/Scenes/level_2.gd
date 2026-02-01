extends Node2D

func _on_red_mask_body_entered(body):
	var orphaned_node = get_node("RedMask")
	remove_child(orphaned_node)
	print("carsick")
	


func _on_gold_mask_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
