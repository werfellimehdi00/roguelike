extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
var direction
@export var speed = 00 
var health:float
var player = null
var colors = [preload("res://graphics/cars/green.png"),
				 preload("res://graphics/cars/red.png")
			   ,preload("res://graphics/cars/yellow.png")]

func _ready() -> void:
	
	player = get_node("../Player")
	$Sprite2D.texture = colors.pick_random()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if player:
		direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	if player.global_position.x > global_position.x:
		$Sprite2D.flip_h = true  # facing right
	else:
		$Sprite2D.flip_h = false  # facing left
#look_at(player.global_position)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.
