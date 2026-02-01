extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioController.play_title()
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	print("Start pressed")
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")
	AudioController.stop_title()
	AudioController.play_music()
	AudioController.play_ambiance()


func _on_credit_button_pressed() -> void:
	print("Credits pressed")
	get_tree().change_scene_to_file("res://Scenes/CreditScreen.tscn")

func _on_quit_button_pressed() -> void:
	print("Quit pressed")
	get_tree().quit()
