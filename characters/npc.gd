extends "res://characters/abstract/base_character.gd"

@onready var interaction_area: InteractionArea = $InteractionArea
@export var dialogue: DialogueResource

signal npc_attack(damage, area_id)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if (!GameState.in_dialog):
		DialogueManager.show_example_dialogue_balloon(dialogue)
		GameState.in_dialog = true

func _on_enemy_entered_npc_range():
	print('enemy')
	
func _on_sword_hit_area_entered(area:Area2D):
	print("hit")
	if(area.name=='hurtbox'):
		npc_attack.emit(dmg,area.get_instance_id())
		print("HIT THI",area.get_instance_id())
	
