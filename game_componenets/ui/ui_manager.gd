extends Control

@onready var player_inv_ui = $PlayerInventoryUI
@onready var other_inv_ui = $OtherInventoryUI
@onready var invs_array: Array = get_tree().get_nodes_in_group("inventories")

signal closed_inv_ui

var can_close: bool = true

func _ready():
	for i in invs_array.size():
		invs_array[i].opened.connect(open_inventory)

func _process(_delta):
	if Input.is_action_just_pressed("interact") and other_inv_ui.is_open == true and can_close == true:
		close_inventory()
	can_close = true
	if Input.is_action_just_pressed("inventory"):
		handle_player_invnetory()

func handle_player_invnetory():
	if !player_inv_ui.is_open:
		GameState.in_dialog = true
		player_inv_ui.is_open = true
	else:
		GameState.in_dialog = false
		player_inv_ui.is_open = false 

func open_inventory(inv: Inv):
	if !other_inv_ui.is_open:
		GameState.in_dialog = true
		other_inv_ui.inv = inv
		other_inv_ui.update_slots()
		other_inv_ui.is_open = true
		can_close = false
	
func close_inventory():
		GameState.in_dialog = false
		other_inv_ui.is_open = false
		closed_inv_ui.emit()
