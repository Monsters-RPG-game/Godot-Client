extends Control

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var inv: Inv = self.get_parent().inv
var is_open = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
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
