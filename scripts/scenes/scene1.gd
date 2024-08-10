extends "res://scripts/scenes/abstract_scene.gd"

var SceneController = load("res://scripts/shared/scene_manager.gd").new()

func _ready():
	match GlobalSceneState.last_scene:
		"GlobalMap":
			$Player.position = Vector2(137, 165)
			return
		"":
			return
	print("Outside switch. Possibly new doors not implemented ?. If ")

func _scene_exit_doors(body):
	if(body.get_name() == "Player"):
		SceneController.switch_scene(get_tree().change_scene_to_file, get_tree().current_scene.name, "res://levels/global_map.tscn")
