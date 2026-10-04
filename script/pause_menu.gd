extends CanvasLayer

@onready var resume_button: TextureButton = %ResumeButton
@onready var menu_button: TextureButton = %MenuButton

func _ready() -> void:
	hide()
	resume_button.pressed.connect(toggle_pause)
	menu_button.pressed.connect(_on_menu_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not event.is_echo():
		toggle_pause()
		get_viewport().set_input_as_handled()

func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused

func _on_menu_pressed() -> void:
	get_tree().paused = false
	GimManager.reset()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
