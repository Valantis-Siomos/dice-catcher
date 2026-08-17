class_name Dice
extends Area2D

signal off_screen

const SPEED: float = 80.0
const BUFFER: float = 60.0
const ROTATION_SPEED: float = 2 * PI

@onready var sprite_2d: Sprite2D = $Sprite2D

var _rotation_speed: float = ROTATION_SPEED

func _ready() -> void:
	if randf() < 0.5: _rotation_speed *= -1
	position.x = randf_range(
		get_viewport_rect().position.x + BUFFER	,
		get_viewport_rect().end.x - BUFFER,
	)
	position.y = get_viewport_rect().position.y - BUFFER


func _physics_process(delta: float) -> void:
	position.y += SPEED * delta
	sprite_2d.rotate(_rotation_speed * delta)
	check_off_screen()


func check_off_screen() -> void:
	if get_viewport_rect().end.y < position.y:
		get_tree().paused = true
		off_screen.emit()
		#queue_free()
