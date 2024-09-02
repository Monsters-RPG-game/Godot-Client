extends BaseCharacter

signal player_attack(damage,area_id)

#@onready var inv_ui = $PlayerInventoryUI

func _ready():
	#inv_ui.visible = false
	update_animation_parameter(starting_direction)

func _physics_process(delta): 
	#handle_inventory()
	if (!GameState.in_dialog):
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
		if not is_attacking:  
			update_animation_parameter(input_direction)
			velocity = input_direction * SPEED * delta
			move_and_slide()
		
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

#func handle_inventory():
	#if Input.is_action_just_pressed("inventory") and !inv_ui.is_open:
		#GameState.in_dialog = true
		#inv_ui.is_open = true
	#elif Input.is_action_just_pressed("inventory") and inv_ui.is_open:
		#GameState.in_dialog = false
		#inv_ui.is_open = false
		
		
