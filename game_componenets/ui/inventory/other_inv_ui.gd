extends "res://game_componenets/ui/inventory/inv_ui.gd"

@onready var invs_array: Array = get_tree().get_nodes_in_group("inventories")

func _ready():
	for i in slots.size():
		slots[i].item_taken.connect(delete_item_on_slot)
		slots[i].item_droped.connect(insert_item_into_slot)
	is_open = false
	visible = false
