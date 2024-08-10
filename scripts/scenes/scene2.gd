extends "res://scripts/scenes/abstract_scene.gd"

func _main_house_enter(body):
	if(body.get_name() == "Player"):
		get_tree().change_scene_to_file("res://levels/scene1.tscn")
