extends Node2D

# Called when the node enters the scene tree for the first time.
@onready var enemy=preload("res://characters/enemy.tscn")

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _ready():
	spawn_enemy()
	
func spawn_enemy():
	var area=$Map/Spawn as ReferenceRect
	var rand_pos=area.position + Vector2(randf()*area.size.x,randf()*area.size.y)
	var enemy_instance=enemy.instantiate()
	enemy_instance.position=rand_pos
	var map=$Map
	map.add_child(enemy_instance)
