class_name Fox

extends Area2D

signal eaten_dice

@export var speed: float = 300.0
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sound: AudioStreamPlayer = $sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var move: float = Input.get_axis("fox_left", "fox_right")
	if !is_zero_approx(move):
		sprite_2d.flip_h = move > 0.0
	position.x += move * delta * speed


func _on_area_entered(area: Area2D) -> void:
	if area is Dice:
		area.queue_free()
		sound.play()
		eaten_dice.emit()
	
	
	
