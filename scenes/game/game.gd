extends Node

#const DICE = preload("res://scenes/dice/dice.tscn")
const GAME_OVER = preload("uid://c0orcx0ncovyq")


@export var dice_scene: PackedScene
@onready var score_label: Label = $ScoreLabel
@onready var sound: AudioStreamPlayer = $Sound

var _score: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_dice()



func spawn_dice() -> void:
	var new_dice: Dice = dice_scene.instantiate()
	new_dice.off_screen.connect(game_over)
	add_child(new_dice)

func game_over() -> void:
	sound.stop()
	sound.stream = GAME_OVER
	sound.play()

func _on_spawn_timer_timeout() -> void:
	spawn_dice()


func _on_fox_eaten_dice() -> void:
	_score += 1
	score_label.text = "%4d" % _score
