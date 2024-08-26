extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@export var dialogue: DialogueResource

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogueManager.show_example_dialogue_balloon(dialogue)
