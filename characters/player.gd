extends CharacterBody2D

@export var starting_direction : Vector2 = Vector2(0, 1.1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var attack_timer = $AttackTimer  # Reference to the Timer node
var is_attacking=false
const SPEED = 6000

func _ready():
	update_animation_parameter(starting_direction)

func _physics_process(delta): 
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if not is_attacking:  # Only update movement if not attacking
		update_animation_parameter(input_direction)
		velocity = input_direction * SPEED * delta
		move_and_slide()

	handle_attack()
	pick_new_state()

func update_animation_parameter(move_input : Vector2): 

	if(move_input != Vector2.ZERO):
		print("move input",move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Attack/blend_position", move_input)
		
func handle_attack():
	if Input.is_action_just_pressed("attack") and not is_attacking: 
		is_attacking = true
		attack_timer.start()


func pick_new_state():
	if is_attacking:
		state_machine.travel("Attack")
	elif velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")


func _on_attack_timer_timeout():
	is_attacking=false


func _on_area_2d_body_entered(_body):
	get_tree().change_scene_to_file("res://scenes/secondlevel.tscn")
