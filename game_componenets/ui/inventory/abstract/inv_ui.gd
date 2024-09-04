extends Control

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var inv: Inv

var is_open = false

func _process(_delta):
	if is_open:
		visible = true
	else: 
		visible = false
		
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func delete_item_on_slot(slot_id: int):
	var slot = inv.slots[slot_id-1]
	GameState.grabed_item.item = slot.item
	GameState.grabed_item.amount = slot.amount
	slot.amount = 0
	slot.item = null
	update_slots()

func insert_item_into_slot(slot_id: int):
	var slot = inv.slots[slot_id-1]
	if slot.item != GameState.grabed_item.item:
		slot.amount = GameState.grabed_item.amount
		slot.item = GameState.grabed_item.item
		GameState.grabed_item = InvSlot.new()
		update_slots()
	else:
		inv.insert(GameState.grabed_item.item, GameState.grabed_item.amount)
		GameState.grabed_item = InvSlot.new()
		update_slots()
