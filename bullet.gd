extends Area2D

@export var speed = 500
@export var damage_amount = 10
var target = null

func _physics_process(delta):
	if is_instance_valid(target):
		# Move toward the car
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta
		look_at(target.global_position)
	else:
		# If target is destroyed by something else, remove bullet
		queue_free()

func _on_area_entered(area):
	if area is HitboxComponent: 
		var attack = Attack.new() 
		attack.attack_damage = damage_amount 
		attack.attack_position = global_position 
		
		area.damage(attack) 
		queue_free() # Destroy bullet after hit
