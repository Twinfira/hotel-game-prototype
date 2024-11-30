extends Node

enum Rating {
	MISS = 0,
	BAD = 25,
	GOOD = 50,
	GREAT = 75,
	PERFECT = 100
}

@export var score: int = 0
@export var combo: int = 0
@export_category("Combo settings")
#Combo treshold is how much combo you need before you go to the next 'level' of combo
@export var combo_multiplier: float = 2.0
@export var combo_threshold: int = 5

func add_score(accuracy: float) -> void:
	var rating: Rating
	
	match accuracy:
		_ when accuracy >= 0.90:
			rating = Rating.PERFECT
		_ when accuracy >= 0.75:
			rating = Rating.GREAT
		_ when accuracy >= 0.50:
			rating = Rating.GOOD
		_ when accuracy >= 0.25:
			rating = Rating.BAD
		_:
			rating = Rating.MISS
	
	match rating:
		Rating.MISS:
			reset_combo()
		_:
			var base_points = rating
			var current_multiplier = pow(combo_multiplier, combo / combo_threshold)
			var points = int(base_points * current_multiplier)
			score += points
			combo += 1
	
	print(Rating.find_key(rating) + "! Score: ", score, " Combo: ", combo)

func reset_combo() -> void:
	combo = 0
	print("MISS! Score: ", score, " Combo: ", combo)
