extends "res://characters/abstract/base_character.gd"

@onready var player_node:Node2D = get_node("/root/Level/Map/Player")

signal player_attack(damage,area_id)

var last_pos: Vector2 = Vector2()

func _ready():
	update_animation_parameter(starting_direction)

func _physics_process(delta): 
	if (!GameState.in_dialog):
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
		if not is_attacking:
			update_animation_parameter(input_direction)
			velocity = input_direction * SPEED * delta
			move_and_slide()
		
		emit_location()
		handle_attack()
		pick_new_state()

func handle_attack():
	if Input.is_action_just_pressed("attack") and not is_attacking: 
		is_attacking = true
		attack_timer.start()

func _on_sword_hit_area_entered(area:Area2D):
	if(area.name=='hurtbox'):
		player_attack.emit(dmg,area.get_instance_id())
		print("HIT THI",area.get_instance_id())

func emit_location():
		if(last_pos != player_node.position):
			last_pos = player_node.position
			UdpConnection.send_message(JSON.stringify(last_pos))
