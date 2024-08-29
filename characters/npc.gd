extends "res://characters/abstract/base_character.gd"

@onready var detection_area: DetectionArea = $DetectionArea
@onready var interaction_area: InteractionArea = $InteractionArea
@export var dialogue: DialogueResource

signal npc_attack(damage, area_id)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _physics_process(delta):
	if (detection_area.detected_array.size() > 0 and not is_attacking):
		var target_position=(detection_area.detected_array[0].position - position).normalized()
		velocity = target_position * SPEED * delta
		update_animation_parameter(target_position)
		move_and_slide()
	else: 
		velocity = Vector2.ZERO
	pick_new_state()

func _on_interact():
	if (!GameState.in_dialog):
		DialogueManager.show_example_dialogue_balloon(dialogue)
		GameState.in_dialog = true

func _on_sword_hit_area_entered(area:Area2D):
	print("hit")
	if(area.name=='hurtbox'):
		npc_attack.emit(dmg,area.get_instance_id())
		print("HIT THI",area.get_instance_id())
	
func _on_attack_detection(_area):
	is_attacking = true
	attack_timer.start()

