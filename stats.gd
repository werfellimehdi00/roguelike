extends Resource

class_name Stats

@export var max_health: int = 100
@export var current_health: int = 100
@export var attack: int = 20
@export var attack_speed: int = 100

var health: int = 0

func _init()->void:
	setup_stats.call_deferred()
 
func setup_stats()->void:
	health= max_health
	print(health)
