extends Node

var enemy_node=preload("res://characters/enemy.tscn")
var allowed:Array[String]
var area:ReferenceRect
var map:Node2D

func initialize(area_spawn:ReferenceRect,map_spawn:Node2D):
	area=area_spawn
	map=map_spawn
	
func allow_enemies(enemy:String):
	allowed.push_front(enemy)	

func spawn(amount:int):
	print(area)
	if !area:
		print("No area selected to spawn enemies")
		return
		
	for cos in amount:
		var enemy_name=allowed[randi()%allowed.size()]
		var enemy=find_enemy(enemy_name)	
		var rand_pos=area.position + Vector2(randf()*area.size.x,randf()*area.size.y)
		enemy.position=rand_pos
		map.add_child(enemy)
		
func find_enemy(enemy:String):
	if enemy=="enemy":
		return enemy_node.instantiate()
