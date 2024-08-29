extends "res://characters/abstract/base_character.gd"

@onready var detection_area: DetectionArea = $DetectionArea
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var raycast: RayCast2D = $RayCast2D
@export var dialogue: DialogueResource

signal npc_attack(damage, area_id)

func _ready():
	print(raycast)
	raycast.enabled = false
	interaction_area.interact = Callable(self, "_on_interact")

func _physics_process(delta):
	behavior(delta)
	pick_new_state()

func behavior(delta):
	if (detection_area.detected_array.size() > 0):
		var target_position=(detection_area.detected_array[0].position - position).normalized()
		var is_obstacle=check_for_obstacle(detection_area.detected_array[0])
		if is_obstacle:
			target_position = target_position.rotated(PI/4)
		update_animation_parameter(target_position)
		if ((detection_area.detected_array[0].position - position).length() <= 15):
			attack()
		elif not is_attacking:
			velocity = target_position * SPEED * delta
			move_and_slide()
		
	else: 
		velocity = Vector2.ZERO
		
func attack():
	is_attacking = true
	attack_timer.start()
	
func check_for_obstacle(target:CharacterBody2D)->bool:
	raycast.target_position=target.global_position-self.global_position
	raycast.enabled=true
	return raycast.is_colliding()

func _on_interact():
	if (!GameState.in_dialog):
		DialogueManager.show_example_dialogue_balloon(dialogue)
		GameState.in_dialog = true

func _on_sword_hit_area_entered(area:Area2D):
	print("hit")
	if(area.name=='hurtbox'):
		npc_attack.emit(dmg,area.get_instance_id())
		print("HIT THI",area.get_instance_id())
