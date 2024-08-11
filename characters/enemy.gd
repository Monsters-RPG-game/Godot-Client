extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var hp=100
var is_dying=false

@onready var player_node = get_node("/root/Node2D/Player")  # Adjust path to your scene structure
@onready var anim_player = $AnimationPlayer  # Assuming the AnimationPlayer is a child of this node

func _ready():
	if player_node != null:
		player_node.connect("player_attack", _on_player_attack)
	else:
		print("Player node not found in the scene!")
		
func _process(_delta):
	if(hp<=0 and not is_dying):
		die()
		
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
