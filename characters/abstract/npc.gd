extends BaseCharacter

@onready var detection_area: DetectionArea = $DetectionArea
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var raycast: RayCast2D = $RayCast2D
@onready var starting_position: Vector2 = position
@export var dialogue: DialogueResource

signal npc_attack(damage, area_id)

func _ready():
	print(starting_position)
	raycast.enabled = false
	interaction_area.interact = Callable(self, "_on_interact")

func _physics_process(delta):
	behavior(delta)
	pick_new_state()

func behavior(delta):
	if (detection_area.detected_array.size() > 0):
		#attacks if an enemy was detected
		var target = detection_area.detected_array[0]
		var move_direction = find_path(target.position)
		if ((target.position - position).length() <= 15):
		#performs attack if enemy is close
			attack()
		elif not is_attacking:
		#if not perfoming attack, moves to an enemy
			velocity = move_direction * SPEED * delta
			move_and_slide()
	elif (starting_position - position).length() > 1 and not is_attacking:
		#if not at starting position and not following enemy returns to starting position
		var move_direction = find_path(starting_position)
		velocity = move_direction * SPEED * delta
		move_and_slide()
	else: 
		#stays still if all above are falls
		velocity = Vector2.ZERO


func find_path(target) -> Vector2:
	var target_position=(target - position).normalized()
	raycast.target_position = target_position
	raycast.enabled = true
	var move_direction = target_position
	if (raycast.is_colliding()):
		print('obstacle')
		move_direction = move_direction.rotated(PI/4)
	update_animation_parameter(target_position)
	return move_direction

func attack():
	is_attacking = true
	attack_timer.start()

func _on_interact():
	if (!GameState.in_dialog):
		DialogueManager.show_example_dialogue_balloon(dialogue)
		GameState.in_dialog = true

func _on_sword_hit_area_entered(area:Area2D):
	print("hit")
	if(area.name=='hurtbox'):
		npc_attack.emit(dmg,area.get_instance_id())
		print("HIT THI",area.get_instance_id())
