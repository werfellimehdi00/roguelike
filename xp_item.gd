extends Area2D

@export var xp_value : int = 10

func _ready():
	# Connect the signal that detects when a body enters the area
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if the body that touched us is the Player
	if body.name == "Player":
		# 1. Tell the player (or Global script) to gain XP
		if Global.has_method("add_xp"):
			Global.add_xp(10)
		
		# 2. Remove the battery from the world
		queue_free()
