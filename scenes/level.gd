extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var enemySpawn = $Node2D/EnemySpawn
@onready var enemy=preload("res://characters/enemy.tscn")
@onready var enemy2=preload("res://characters/enemy.tscn")

func _ready():
	var collison=enemySpawn.get_node("CollisionShape2D")
	var rand_pos=generate_random_position(collison)
	var rand_pos2=generate_random_position(collison)
	var enemy_instance=enemy.instantiate()
	var enemy_instance2=enemy2.instantiate()
	enemy_instance.position=rand_pos
	enemy_instance2.position=rand_pos2
	
	add_child(enemy_instance)
	add_child(enemy_instance2)

func generate_random_position(coll_shape:CollisionShape2D)->Vector2:
	var size=coll_shape.get_shape().get_rect()
	var rand_x=randi_range(size.position.x,size.position.x+size.size.x)
	var rand_y=randi_range(size.position.y,size.position.y+size.size.y)
	
	return coll_shape.global_position + Vector2(rand_x,rand_y)
