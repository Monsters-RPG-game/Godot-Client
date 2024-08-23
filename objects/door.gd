extends Node2D
class_name Door

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

var is_open = false

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	if is_open == false: 
		interaction_area.action_name = "close"
		is_open = true
		collision.disabled = true
		sprite.frame = 1
	else:
		interaction_area.action_name = "open"
		is_open = false
		collision.disabled = false
		sprite.frame = 0
