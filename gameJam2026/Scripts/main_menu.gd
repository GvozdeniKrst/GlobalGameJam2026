extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	print("Start pressed")
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_credit_button_pressed() -> void:
	print("Credits pressed")

func _on_quit_button_pressed() -> void:
	print("Quit pressed")
	get_tree().quit()
