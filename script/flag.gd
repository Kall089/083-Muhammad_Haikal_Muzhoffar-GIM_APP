extends Area2D

@onready var win_dialog: AcceptDialog = $WinDialog

var level_completed := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	win_dialog.confirmed.connect(_on_win_dialog_confirmed)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or level_completed:
		return
	level_completed = true
	win_dialog.popup_centered()

func _on_win_dialog_confirmed() -> void:
	GimManager.reset()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
