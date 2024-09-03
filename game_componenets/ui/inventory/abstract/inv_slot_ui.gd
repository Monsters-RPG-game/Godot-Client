extends Panel
class_name UIInvSlot

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount_label: Label = $CenterContainer/Panel/AmountLabel
@onready var slot: InvSlot

var focused = false
var grabed = false

func _process(_delta):
	if focused:
		if Input.is_action_just_pressed('l_click') and !GameState.grabed_item:
			GameState.grabed_item = slot
			var empty_slot: InvSlot = InvSlot.new()
			empty_slot.item = null
			empty_slot.amount = 0
			update(empty_slot)
		if Input.is_action_just_released("l_click") and GameState.grabed_item:
			update(GameState.grabed_item)
			GameState.grabed_item = null


func update(new_slot: InvSlot):
	if !new_slot.item:
		item_display.visible = false
		amount_label.visible = false
		slot = null
	else:
		print('updated')
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
