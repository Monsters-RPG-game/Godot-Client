extends CharacterBody2D


@export var hp=100
@export var min_distance_to_player=15
@onready var player_node:Node2D = get_node("/root/Node2D/Player")  # Adjust path to your scene structure
@onready var anim_player = $AnimationPlayer  # Assuming the AnimationPlayer is a child of this node
@onready var raycast = $RayCast2D as RayCast2D 

const SPEED = 2000.0
const JUMP_VELOCITY = -400.0
var is_dying=false

func _ready():
	raycast.enabled = false

	self.add_to_group("depth_sorted")
	if player_node != null:
		player_node.connect("player_attack", _on_player_attack)
	else:
		print("Player node not found in the scene!")
		
func _process(_delta):
	if(hp<=0 and not is_dying):
		die()
		
func _physics_process(delta):
	var is_obstacle=check_for_obstacle(player_node)
	var player_position=player_node.position
	var target_position=(player_position-position).normalized()
	if position.distance_to(player_position)>min_distance_to_player:
		var move_direction = target_position
		if is_obstacle:
			move_direction =move_direction.rotated(PI/4) 
		velocity = move_direction * SPEED * delta
		move_and_slide()
		
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
	queue_free()  # Destroys this node
	
func check_for_obstacle(target:CharacterBody2D)->bool:
	raycast.target_position=target.global_position-self.global_position
	raycast.enabled=true
	return raycast.is_colliding()
