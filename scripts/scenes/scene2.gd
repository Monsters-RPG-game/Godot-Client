extends "res://scripts/scenes/abstract_scene.gd"

var SceneController = load("res://scripts/shared/scene_manager.gd").new()

func _ready():
	match GlobalSceneState.last_scene:
		"StartingHome":
			$Player.position = Vector2(200, 170)
			return
			
	print("Outside switch. Possibly new scene not implemented ?")


func _main_house_enter(body):
	if(body.get_name() == "Player"):
		SceneController.switch_scene(get_tree().change_scene_to_file, get_tree().current_scene.name, "res://levels/scene1.tscn")
