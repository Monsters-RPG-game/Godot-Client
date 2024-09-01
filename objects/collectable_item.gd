extends Node2D
class_name CollecteableItem

@onready var player: BaseCharacter = get_tree().get_first_node_in_group("player")
@onready var interaction_area: InteractionArea = $InteractionArea
@export var item: InvItem
@export var amount: = 1

func _ready():
	$Sprite2D.texture = item.texture
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	player.inv.insert(item, amount)
	self.queue_free()
