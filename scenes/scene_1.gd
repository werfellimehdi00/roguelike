extends Node2D

var player: CharacterBody2D
@export var spawn_distance: float = 1000.0
# Called when the node enters the scene tree for the first time.
var carscene : PackedScene = preload("res://car.tscn")

var score: int


func _ready()-> void:
	player = get_tree().get_first_node_in_group("player")


func go_title():
	get_tree().change_scene_to_file("res://interface_1.tscn")



func get_random_spawn_position() -> Vector2:
	var max_attempts = 10 # Don't loop forever if the map is too crowded  
	for i in range(max_attempts):
		print("Player is currently at: ", player.global_position)
	# 1. Choose a random direction (TAU = 360 degrees)
		var random_angle = randf() * TAU
		var direction = Vector2(cos(random_angle), sin(random_angle)) 
		var test_pos = player.global_position + (direction * spawn_distance)   
		# 3. Ask the physics engine: "Is this spot clear?"
		if is_spot_empty(test_pos):
			return test_pos
	var fallback_angle = randf() * TAU
	return player.global_position + (Vector2(cos(fallback_angle), sin(fallback_angle)) * 350.0)


func is_spot_empty(pos: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	
	# Define a query (a search) for a circle shape
	var query = PhysicsShapeQueryParameters2D.new()
	var circle = CircleShape2D.new()
	circle.radius = 50.0 # Match this roughly to your car's collision size
	
	query.shape = circle
	query.transform = Transform2D(0, pos)
	
	# 1 is the Layer your trees/objects are on. 
	# Check "Collision Layer" in your Tree's inspector!
	query.collision_mask = 18
	
	# Check for intersections
	var result = space_state.intersect_shape(query)
	return result.is_empty() # Returns TRUE if nothing is blocking the spot


func _on_cartimer_timeout() -> void:
	if player == null: return # Safety check  
	var spawn_pos = get_random_spawn_position()
	if spawn_pos != Vector2.ZERO:
		var car = carscene.instantiate()
		car.global_position = spawn_pos
		$objects.add_child(car)


func _on_scoretimer_timeout() -> void:
	score += 1
	$CanvasLayer/Label.text = "score: " + str(score)
