extends CharacterBody2D
class_name BaseCharacter

@onready var animation_tree = $AnimationTree
@onready var attack_timer = $AttackTimer  
@onready var character_sprite = $Sprite2D  
@onready var object_sprite = $Sprite2D
@onready var state_machine = animation_tree.get("parameters/playback")
@export var inv: Inv
@export var dmg=60
@export var hp=100
@export var SPEED = 6000
@export var starting_direction : Vector2 = Vector2(0, 1.1)

var is_attacking=false

func _ready():
	update_animation_parameter(starting_direction)

func update_animation_parameter(move_input : Vector2): 
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Attack/blend_position", move_input)

func pick_new_state():
	if is_attacking:
		state_machine.travel("Attack")
	elif velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

func _on_attack_timer_timeout():
	is_attacking=false
