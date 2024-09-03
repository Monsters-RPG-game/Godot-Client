extends StaticBody2D
class_name Chest

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@export var inv: Inv 

signal opened(inv)

var is_open = false

func _ready():
	UIManager.closed_inv_ui.connect(close)
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	if is_open == false: 
		is_open = true
		interaction_area.action_name = "close"
		state_machine.travel("Opening")
		opened.emit(inv)

func close():
		is_open = false
		interaction_area.action_name = "open"
		state_machine.travel("Closing")
