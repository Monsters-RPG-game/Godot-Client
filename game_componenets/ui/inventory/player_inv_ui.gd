extends "res://game_componenets/ui/inventory/inv_ui.gd"

func _ready():
	inv = get_tree().get_first_node_in_group('player').inv
	for i in slots.size():
		slots[i].item_taken.connect(delete_item_on_slot)
		slots[i].item_droped.connect(insert_item_into_slot)
	inv.update.connect(update_slots)
	update_slots()
	is_open = false
	visible = false
	


