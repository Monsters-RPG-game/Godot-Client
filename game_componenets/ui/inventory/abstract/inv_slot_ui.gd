extends Panel
class_name UIInvSlot

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount_label: Label = $CenterContainer/Panel/AmountLabel

var focused = false

func update(slot: InvSlot):
	if !slot.item:
		item_display.visible = false
		amount_label.visible = false
	else:
		item_display.visible = true
		item_display.texture = slot.item.texture 
		if slot.amount == 1 or !slot.item.stackable:
			amount_label.visible = false
		else:
			amount_label.text = str(slot.amount)
			amount_label.visible = true


func _on_mouse_entered():
	$Sprite2D.modulate = '49ffff'
	focused = true

func _on_mouse_exited():
	$Sprite2D.modulate = 'ffffff'
	focused = false
