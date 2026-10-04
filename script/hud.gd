extends CanvasLayer

@onready var lives_label: Label = %LivesLabel
@onready var score_label: Label = %ScoreLabel

func _ready() -> void:
	GimManager.lives_changed.connect(_update_lives)
	GimManager.score_changed.connect(_update_score)
	_update_lives(GimManager.lives)
	_update_score(GimManager.score)

func _update_lives(lives: int) -> void:
	lives_label.text = "Lives: %d" % lives

func _update_score(score: int) -> void:
	score_label.text = "Coins: %d" % score