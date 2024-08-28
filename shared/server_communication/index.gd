#extends Node
#
#@onready var udp_communication = load("res://shared/server_communication/udp.gd").new()
#
#var connected: bool = false
#
#func _ready() -> void:
	#_init_connection()
#
#func _init_connection() -> void:
	#var tokens = _read_tokens()
	#udp_communication.init_connection()
	#udp_communication.send_message("Test")
#
#func _read_tokens() -> Dictionary:
	#var file = FileAccess.open("user://user_settings.json", FileAccess.READ)
	#var parsed = JSON.parse_string(file.get_as_text())
	#file.close()
	#return { "access": parsed.access, "refresh": parsed.refresh}

#func log_in(tokens: Dictionary) -> void:
	#_save_tokens(tokens)
#
#func _save_tokens(tokens: Dictionary) -> void:
	#var file = FileAccess.open("user://user_settings.json", FileAccess.WRITE)
	#var parsed = JSON.stringify({ "access": tokens.access_token, "refresh": tokens.refresh_token })
	#file.store_string(parsed)
	#file.close()
