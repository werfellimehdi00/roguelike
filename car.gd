extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
var direction
@export var speed = 00 
@export var damage_amount = 10
var health:float
var player = null
var colors = [preload("res://graphics/cars/green.png"),
				 preload("res://graphics/cars/red.png")
			   ,preload("res://graphics/cars/yellow.png")]

func _ready() -> void:
	
	player = get_tree().get_first_node_in_group("player")
	$Sprite2D.texture = colors.pick_random()
	if player:
		print("Car found player at: ", player.global_position)
		
		
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

func _on_hitboxcomponent_body_entered(body: Node2D) -> void:
	# 1. Debug Print: If this doesn't show in the console, the SIGNAL is broken
	print("Car touched something: ", body.name) 
	
	# 2. Check if the thing we hit is the Player
	if body.name == "Player":
		print("Confirmed: Hit the Player!")
		
		# 3. Look for the component that handles health
		if body.has_node("HitboxComponent"):
			var player_hitbox = body.get_node("HitboxComponent")
			
			if player_hitbox is HitboxComponent:
				# 4. Create and send the attack data
				var attack = Attack.new()
				attack.attack_damage = 10
				attack.knockback_force = 150
				attack.attack_position = global_position 
				
				player_hitbox.damage(attack)
