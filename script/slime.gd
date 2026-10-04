extends CharacterBody2D

@export var speed := 30.0
var direction := -1
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_check: RayCast2D = $FloorCheck
@onready var hitbox: Area2D = $Hitbox

func _ready() -> void:
	hitbox.body_entered.connect(_on_hitbox_body_entered)
	sprite.play("move")

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = direction * speed
	move_and_slide()
	if is_on_wall() or not floor_check.is_colliding():
		direction *= -1
		floor_check.position.x = 8 * direction

func _on_hitbox_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or not body is CharacterBody2D:
		return
	var player := body as CharacterBody2D
	if player.velocity.y > 0 and player.global_position.y < global_position.y - 4:
		player.call("jump", -220.0)
		GimManager.add_score(5)
		queue_free()
	else:
		player.call("hurt")
