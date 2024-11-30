extends Node

@export var score_manager: Node2D
@export var hit_detector: Node2D
@export var note_spawner: Node2D

func _ready():
	hit_detector.note_hit.connect(_on_note_hit)
	hit_detector.note_missed.connect(_on_note_missed)

func _on_note_hit(accuracy: float):
	score_manager.add_score(accuracy)

func _on_note_missed():
	score_manager.reset_combo()
