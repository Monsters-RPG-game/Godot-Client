extends "res://characters/abstract/base_character.gd"

@onready var detection_area: DetectionArea = $DetectionArea
@onready var interaction_area: InteractionArea = $InteractionArea
@export var dialogue: DialogueResource

signal npc_attack(damage, area_id)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _physics_process(delta):
	if (detection_area.detected_array.size() > 0):
		var target_position=(detection_area.detected_array[0].position - position).normalized()
		update_animation_parameter(target_position)
		if ((detection_area.detected_array[0].position - position).length() <= 15):
			attack()
		elif not is_attacking:
			velocity = target_position * SPEED * delta
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
	
func attack():
		is_attacking = true
		attack_timer.start()


