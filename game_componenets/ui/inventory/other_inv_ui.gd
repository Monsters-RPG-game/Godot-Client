extends Control

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var inv: Inv
@onready var invs_array: Array = get_tree().get_nodes_in_group("inventories")

var is_open = false

func _ready():
	for i in invs_array.size():
		invs_array[i].opened.connect(update_slots)
	is_open = false
	visible = false
	
func _process(_delta):
	if is_open:
		visible = true
	else: 
		visible = false
		
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
