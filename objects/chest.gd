extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var ui = $ChestInventoryUI
@export var inventory: Inventory

var is_open = false

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	if is_open == false: 
		interaction_area.action_name = "close"
		is_open = true
		state_machine.travel("Opening")
		ui.is_open = true
	else:
		interaction_area.action_name = "open"
		is_open = false
		ui.is_open = false
		state_machine.travel("Closing")
