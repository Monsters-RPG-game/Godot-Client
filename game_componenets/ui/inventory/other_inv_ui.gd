extends Control

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var invs_array: Array = get_tree().get_nodes_in_group("inventories")
var inv: Inv

var is_open = false

func _ready():
	for i in slots.size():
		slots[i].item_taken.connect(delete_item_on_slot)
		slots[i].item_droped.connect(insert_item_into_slot)
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

func delete_item_on_slot(slot_id: int):
	GameState.grabed_item.item = inv.slots[slot_id-1].item
	GameState.grabed_item.amount = inv.slots[slot_id-1].amount
	inv.slots[slot_id-1].amount = 0
	inv.slots[slot_id-1].item = null
	update_slots()

func insert_item_into_slot(slot_id: int):
	inv.slots[slot_id-1].amount = GameState.grabed_item.amount
	inv.slots[slot_id-1].item = GameState.grabed_item.item
	GameState.grabed_item = InvSlot.new()
	update_slots()
