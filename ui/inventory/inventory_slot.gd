extends Panel

@onready var item_display: Sprite2D = $ItemDisplay

func update(item: InventoryItem):
	if !item:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = item.texture 
		item_display.scale = Vector2(0.3, 0.3)
