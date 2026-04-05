extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
var direction: Vector2 
var speed: int = 400
@export var bullet_scene: PackedScene
@export var fire_rate: float = 1.0
var fire_timer: float = 0.0

func _process(delta):
	fire_timer += delta
	if fire_timer >= fire_rate:
		fire_at_nearest_enemy()
		fire_timer = 0.0

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	
	direction=Input.get_vector("left","right","up","down")
	animation()
	velocity = direction * speed
	move_and_slide()

func animation():
	if direction:
		$AnimatedSprite2D.flip_h = direction.x > 0
		if direction.x != 0 :
			$AnimatedSprite2D.animation = "left"
		
		else : $AnimatedSprite2D.animation = "down" if direction.y > 0 else "up"
	else :
		$AnimatedSprite2D.frame = 0



  

func fire_at_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest_enemy = null
	var min_dist = INF
	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < min_dist:
			min_dist = dist
			nearest_enemy = enemy
	if nearest_enemy:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.target = nearest_enemy
		get_tree().root.add_child(bullet)
