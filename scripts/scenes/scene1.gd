extends "res://scripts/scenes/abstract_scene.gd"

var SceneController = load("res://scripts/shared/scene_manager.gd").new()

func _ready():
	if(GlobalSceneState.last_scene != ""):
		$Player.position = Vector2(137, 165)

func _scene_exit_doors(body):
	if(body.get_name() == "Player"):
		SceneController.switch_scene(get_tree().change_scene_to_file, get_tree().current_scene.get_path(), "res://levels/scene2.tscn")
