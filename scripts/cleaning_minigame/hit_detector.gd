extends Area2D

signal note_hit(accuracy: float)
signal note_missed

@export var hit_margin: float = 50

func _unhandled_input(event):
	if event.is_action_pressed("hit_note"):
		var closest_note = get_closest_note()
		if closest_note:
			var accuracy = calculate_accuracy(closest_note)
			if accuracy > 0:
				emit_signal("note_hit", accuracy)
				closest_note.queue_free()
			else:
				emit_signal("note_missed")
		else:
			emit_signal("note_missed")

func calculate_accuracy(note: Node2D) -> float:
	var distance = abs(note.position.y - global_position.y)
	if distance > hit_margin:
		return 0.0
	return 1.0 - (distance / hit_margin)

func get_closest_note() -> Node2D:
	var notes = get_overlapping_areas().filter(func(area): return area.is_in_group("Note"))
	if notes.is_empty():
		return null
	
	var closest_note = null
	var closest_distance = INF
	for area in notes:
		var note = area.get_parent()
		var distance = abs(note.position.y - global_position.y)
		if distance < closest_distance:
			closest_distance = distance
			closest_note = note
	
	return closest_note
