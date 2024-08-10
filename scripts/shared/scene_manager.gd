extends Node

func switch_scene(change_scene: Callable, old_scene: String, new_scene: String):
	GlobalSceneState.last_scene = old_scene
	change_scene.call(new_scene)
