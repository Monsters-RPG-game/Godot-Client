extends CharacterBody2D


@onready var animation_tree = $AnimationTree
@export var hp=100
@export var min_distance_to_player=15
@export var max_distance_to_player=200
@export var starting_direction : Vector2 = Vector2(0, 1.1)
@onready var player_node:Node2D = get_node("/root/Level/Map/Player")  
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var anim_player = $AnimationPlayer  
@onready var raycast = $RayCast2D as RayCast2D 

const SPEED = 2000.0
const JUMP_VELOCITY = -400.0
var is_dying=false

func _ready():
	print('enemy',self.z_index)
	raycast.enabled = false
	update_animation_parameter(starting_direction)
	
	if player_node != null:
		# laczymy sie z custom signalem
		player_node.connect("player_attack", _on_player_attack)
	else:
		print("Player node not found in the scene!")
		
func _process(_delta):
	if(hp<=0 and not is_dying):
		die()
		
func _physics_process(delta):
	var is_obstacle=check_for_obstacle(player_node)
	print("OBST",is_obstacle)
	var player_position=player_node.position
	var target_position=(player_position-position).normalized()
	update_animation_parameter(target_position)
	if position.distance_to(player_position)>min_distance_to_player and position.distance_to(player_position)< max_distance_to_player:
		var move_direction = target_position
		# tu mozna dodac bardziej wyrafinowana logike omijania
		if is_obstacle:
			move_direction =move_direction.rotated(PI/4) 
		velocity = move_direction * SPEED * delta
		move_and_slide()
	else:
		velocity=Vector2.ZERO
	pick_new_state()
	
func _on_player_attack(damage: int) -> void:
	print("Enemy hit by player with damage: ", damage)
	if not is_dying and hp > damage:
		anim_player.play("hurt")	
		await anim_player.animation_finished
		
	hp-=damage

func die() -> void:
	if is_dying:
		return
	
	is_dying=true
	print("Enemy has died!")
	anim_player.play("die")
	await anim_player.animation_finished
	queue_free()  # zabija node
	
func check_for_obstacle(target:CharacterBody2D)->bool:
	raycast.target_position=target.global_position-self.global_position
	raycast.enabled=true
	return raycast.is_colliding()
	


func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
func update_animation_parameter(move_input : Vector2): 
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
