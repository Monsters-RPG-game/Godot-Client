extends Node2D

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://levels/MainMenu.tscn")


func _main_house_enter(body):
	if(body.get_name() == "Player"):
		get_tree().change_scene_to_file("res://levels/Scene1.tscn")
