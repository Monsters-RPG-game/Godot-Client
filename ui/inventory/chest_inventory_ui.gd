extends Control

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var inventory: Inventory = self.get_parent().inventory
var is_open = false

func _ready():
	update_slots()
	is_open = false
	visible = false
	
func _process(_delta):
	if is_open:
		visible = true
	else: 
		visible = false
		
func update_slots():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
