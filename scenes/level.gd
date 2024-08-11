extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var enemySpawn = $Node2D/EnemySpawn
@onready var enemy=preload("res://characters/enemy.tscn")
func _ready():
	var collison=enemySpawn.get_node("CollisionShape2D")
	var rand_pos=generate_random_position(collison)
	var enemy_instance=enemy.instantiate()
	enemy_instance.position=rand_pos
	
	add_child(enemy_instance)

func generate_random_position(coll_shape:CollisionShape2D)->Vector2:
	var size=coll_shape.get_shape().get_rect()
	print('asda',size)
	var rand_x=randi_range(size.position.x,size.position.x+size.size.x)
	var rand_y=randi_range(size.position.y,size.position.y+size.size.y)
	
	return coll_shape.global_position + Vector2(rand_x,rand_y)
