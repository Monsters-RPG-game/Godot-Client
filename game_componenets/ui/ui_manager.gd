extends Control

@onready var inv_ui = $PlayerInventoryUI

func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		handle_invnetory()

func handle_invnetory():
	if !inv_ui.is_open:
		GameState.in_dialog = true
		inv_ui.is_open = true
	else:
		GameState.in_dialog = false
		inv_ui.is_open = false 
