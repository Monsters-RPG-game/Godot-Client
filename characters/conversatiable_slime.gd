extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@export var dialogue: DialogueResource

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if (!GameState.in_dialog):
		DialogueManager.show_example_dialogue_balloon(dialogue)
		GameState.in_dialog = true
