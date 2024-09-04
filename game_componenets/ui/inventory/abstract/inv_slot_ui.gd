extends Panel
class_name UIInvSlot

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount_label: Label = $CenterContainer/Panel/AmountLabel
@onready var slot: InvSlot
@export var slot_id :int

signal item_taken(slot_id)
signal item_droped(slot_id)

var focused = false

func _process(_delta):
	if focused:
		if Input.is_action_just_pressed('l_click') and !GameState.grabed_item.item:
			item_taken.emit(slot_id)
		if Input.is_action_just_released("l_click") and GameState.grabed_item.item:
			item_droped.emit(slot_id)


func update(new_slot: InvSlot):
	if !new_slot.item:
		item_display.visible = false
		amount_label.visible = false
		slot = null
	else:
		slot = new_slot
		item_display.visible = true
		item_display.texture = slot.item.texture 
		if new_slot.amount == 1 or !new_slot.item.stackable:
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
