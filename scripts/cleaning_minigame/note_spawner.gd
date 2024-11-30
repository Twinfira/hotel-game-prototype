extends Node

@export var note_scene: PackedScene
@export var spawn_timer: Timer
@export var spawn_location: Node2D
@export var spawn_rate: float = 5

func _ready() -> void:
	spawn_timer.wait_time = spawn_rate

func change_spawn_delay(delay: float) -> void:
	spawn_rate = delay #for global reference in case you wanna do something with it later
	spawn_timer.wait_time = spawn_rate


func _on_spawn_delay_timeout() -> void:
	var note : Node2D = note_scene.instantiate()
	note.position = spawn_location.position
	add_child(note)
	spawn_timer.start()
