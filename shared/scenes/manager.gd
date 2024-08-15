extends Node

@onready var scene_state = load("res://shared/scenes/state.gd").new()

func switch_scene(change_scene: Callable, old_scene: String, new_scene: String):
	scene_state.last_scene = old_scene
	change_scene.call(new_scene)
