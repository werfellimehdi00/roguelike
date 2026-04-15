extends CanvasLayer

func _ready():
	# Connect the buttons to their functions
	$CenterContainer/VBoxContainer/HBoxContainer/Option1.pressed.connect(_on_option_selected.bind("speed"))
	$CenterContainer/VBoxContainer/HBoxContainer/Option2.pressed.connect(_on_option_selected.bind("fire_rate"))
	$CenterContainer/VBoxContainer/HBoxContainer/Option3.pressed.connect(_on_option_selected.bind("health"))

func _on_option_selected(type):
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		match type:
			"speed":
				player.speed += 200
			"fire_rate":
				# Assuming you have a shoot timer on your player
				player.fire_rate *= 0.2
				print("New fire rate: ", player.fire_rate)
			"health":
				player.get_node("Healthcomponent").health += 20
	
	# Close the menu and unpause the game
	get_tree().paused = false
	queue_free()
