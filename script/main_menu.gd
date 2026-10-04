extends Control
@onready var play_button: TextureButton = $CenterContainer/VBoxContainer/PanelContainer/VBoxContainer/PlayButton
@onready var credit_button: TextureButton = $CenterContainer/VBoxContainer/PanelContainer/VBoxContainer/CreditButton
@onready var quit_button: TextureButton = $CenterContainer/VBoxContainer/PanelContainer/VBoxContainer/QuitButton
@onready var credits_dialog: AcceptDialog = $CreditsDialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed);
	credit_button.pressed.connect(_on_credit_button_pressed);
	quit_button.pressed.connect(_on_quit_button_pressed);
	
	for button in [play_button, credit_button, quit_button]:
		button.pivot_offset = button.size / 2
		button.mouse_entered.connect(_grow.bind(button))
		button.mouse_exited.connect(_shrink.bind(button))
	
	play_button.grab_focus()
	modulate.a = 0
	create_tween().tween_property(self, "modulate:a", 1.0, 0.6)

func _on_play_button_pressed() -> void:
	GimManager.reset()
	get_tree().change_scene_to_file("res://scenes/gim_scene.tscn")


func _on_credit_button_pressed() -> void:
	credits_dialog.popup_centered()


func _on_quit_button_pressed() -> void:
	get_tree().quit();

func _grow(button: TextureButton) -> void:
	create_tween().tween_property(button, "scale", Vector2(1.08, 1.08), 0.1)

func _shrink(button: TextureButton) -> void:
	create_tween().tween_property(button, "scale", Vector2.ONE, 0.1)
