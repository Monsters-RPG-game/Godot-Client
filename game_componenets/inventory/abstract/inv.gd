extends Resource
class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem, amount: int): 
	var itemslots: Array[InvSlot] = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty() and itemslots[0].item.stackable:
		itemslots[0].amount += amount
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null) 
		emptyslots.is_empty()
		emptyslots[0].item = item
		emptyslots[0].amount = amount
	update.emit()
