extends Control

func _on_register_pressed():
	get_tree().change_scene_to_file("res://scenes/register.tscn")

func _on_log_in_pressed():
	get_tree().change_scene_to_file("res://scenes/login.tscn")

func _on_exit_pressed():
	get_tree().quit()