extends Node

func load_config():
	var file = FileAccess.open("res://configs/config.json", FileAccess.READ)
	#return JSON.parse_string(file.get_as_text())
