extends Sprite2D

@export var speed: float = 200
	
func _physics_process(delta: float) -> void:
	position.y += speed * delta

func change_speed(new_speed: float) -> void:
	speed = new_speed
