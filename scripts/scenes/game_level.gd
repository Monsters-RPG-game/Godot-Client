extends Node2D

var SceneController = load("res://scripts/sceneManager.gd").new()

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://levels/MainMenu.tscn")

func _ready():
	if(GlobalSceneState.last_scene != ""):
		$Player.position = Vector2(137, 165)

func _scene_exit_doors(body):
	if(body.get_name() == "Player"):
		SceneController.switch_scene(get_tree().change_scene_to_file, get_tree().current_scene.get_path(), "res://levels/Scene2.tscn")
