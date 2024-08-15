extends Node

# Called when the node enters the scene tree for the first time.
@onready var enemy=preload("res://characters/enemy.tscn")
@onready var scene_controller = load("res://shared/scenes/manager.gd").new()
@onready var enemy_controller = load("res://shared/enemies/enemy.gd").new()
@export var enemies_number=1

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _ready():
	spawn_enemy()
	
func spawn_enemy():
	enemy_controller.initialize($Map/Spawn,$Map)
	enemy_controller.allow_enemies("enemy")
	enemy_controller.spawn(enemies_number)
