extends Node2D
class_name Healthcomponent
@export var max_health:=10
var health:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health= max_health

func damage(attack : Attack):
	health -= attack.attack_damage
	if health <=0:
		get_parent().queue_free()
