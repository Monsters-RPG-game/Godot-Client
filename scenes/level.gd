extends "res://scenes/abstract/base.gd"

func _on_area_2d_body_entered(body):
	if(body.get_name() == "Player"):
		scene_controller.switch_scene(get_tree().change_scene_to_file, get_tree().current_scene.name, "res://scenes/secondlevel.tscn")
