extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount_label: Label = $CenterContainer/Panel/AmountLabel

func update(slot: InvSlot):
	if !slot.item:
		item_display.visible = false
		amount_label.visible = false
	else:
		item_display.visible = true
		item_display.texture = slot.item.texture 
		item_display.scale = Vector2(0.3, 0.3)
		if slot.amount == 1 or !slot.item.stackable:
			amount_label.visible = false
		else:
			amount_label.text = str(slot.amount)
			amount_label.visible = true
