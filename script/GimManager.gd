extends Node

signal score_changed(score: int)
signal lives_changed(lives: int)

const MAX_LIVES := 3;
var score := 0;
var lives := MAX_LIVES

func reset() -> void:
	score = 0;
	lives = MAX_LIVES;
	score_changed.emit(score)
	lives_changed.emit(lives)
	
func add_score(amount: int = 1) -> void:
	score += amount;
	score_changed.emit(score);

func lose_life() -> void:
	if lives <= 0:
		return
	lives -= 1;
	lives_changed.emit(lives)
	if (lives <= 0):
		reset();
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
