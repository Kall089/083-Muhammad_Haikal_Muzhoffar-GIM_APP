extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@export var map_left_limit := 5.0
@export var map_right_limit := 427.0

var coyote_time := 0.0
var jump_buffer := 0.0
var spawn_point: Vector2;
var invincible := false;

func _ready() -> void:
	add_to_group("player")
	spawn_point = global_position;


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_time -= delta;
	else:
		coyote_time = 0.1;


	jump_buffer -= delta;
	if Input.is_action_just_pressed("jump"):
		jump_buffer = 0.12;
	if jump_buffer > 0 and coyote_time > 0:
		jump(JUMP_VELOCITY);
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5;
	
	var direction := Input.get_axis("left_walk", "right_walk")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if global_position.y > 200:
		hurt()
		global_position = spawn_point
		velocity = Vector2.ZERO

	move_and_slide()
	if global_position.x < map_left_limit:
		global_position.x = map_left_limit
		velocity.x = 0
	elif global_position.x > map_right_limit:
		global_position.x = map_right_limit
		velocity.x = 0
	_update_animation(direction);
	
func _update_animation(direction: float):
	if direction != 0:
		sprite.flip_h = direction < 0
	if not is_on_floor():
		sprite.play("jump" if velocity.y < 0 else "fall")
	elif direction != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
		
func jump(force: float):
	velocity.y = force;
	jump_buffer = 0;
	coyote_time = 0;

func hurt() -> void:
	if invincible:
		return
	invincible = true
	GimManager.lose_life()
	velocity.y = -200

	var tween := create_tween().set_loops(5)
	tween.tween_property(sprite, "modulate:a", 0.2, 0.08)
	tween.tween_property(sprite, "modulate:a", 1.0, 0.08)
	await tween.finished
	global_position = spawn_point
	velocity = Vector2.ZERO
	invincible = false
	
