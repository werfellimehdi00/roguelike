extends Node2D

@export var attack_damage :=10
@export var knockback_force :=10

func _on_hitbox_body_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack=Attack.new()
		attack.attack_damage=attack_damage
		attack.knockback_force= knockback_force
		attack.attack_position= global_position
		hitbox.damage(attack)
