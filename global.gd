extends Node

# Stats
var score: int = 0
var current_xp: int = 0
var current_level: int = 1
var xp_to_next_level: int = 50 # Level 1 requirement

func add_xp(amount: int):
	current_xp += amount
	print("XP Gained! Current: ", current_xp, "/", xp_to_next_level)
	
	# Check for Level Up
	if current_xp >= xp_to_next_level:
		level_up()

func level_up():
	current_level += 1
	
	# Carry over extra XP (e.g., if you have 55/50, you start next level with 5)
	current_xp -= xp_to_next_level
	
	# Increase the difficulty for the next level (Exponential growth)
	# Level 1: 50 | Level 2: 110 | Level 3: 180...
	xp_to_next_level = int(xp_to_next_level * 1.2) + 50
	get_tree().paused = true
	print("LEVEL UP! You are now Level: ", current_level)
	var menu_scene = preload("res://level_up_menu.tscn").instantiate()
	get_tree().root.add_child(menu_scene)
	# We will trigger the Choice Menu here later!
	# get_tree().paused = true
