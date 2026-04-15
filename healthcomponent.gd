extends Node2D
class_name Healthcomponent


var xp_item_scene = preload("res://xp_item.tscn")
@export var max_health:=100
var health:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health= max_health


func damage(attack : Attack):
	# 1. Update Health
	health -= attack.attack_damage 
	
	# 2. Find the Visual Node (Flexible Check)
	# We try to find the AnimatedSprite2D first; if null, we look for Sprite2D.
	var parent_sprite = get_parent().get_node_or_null("AnimatedSprite2D")
	if parent_sprite == null:
		parent_sprite = get_parent().get_node_or_null("Sprite2D")
	var parent = get_parent()
	if parent is CharacterBody2D:
		var knockback_dir = (parent.global_position - attack.attack_position).normalized()
		if parent.name == "Player":
			parent.knockback_velocity = knockback_dir * attack.knockback_force * 10
	# 3. Visual Feedback Logic
	if parent_sprite:
		# Flash Tween
		var tween = create_tween()
		parent_sprite.modulate = Color(10, 1, 1) # Bright red flash
		tween.tween_property(parent_sprite, "modulate", Color.WHITE, 0.1)
		
		# Shake Tween
		var weight = 1.0
		var shake_tween = create_tween()
		shake_tween.tween_property(parent_sprite, "offset:x", weight, 0.05)
		shake_tween.tween_property(parent_sprite, "offset:x", -weight, 0.05)
		shake_tween.tween_property(parent_sprite, "offset:x", 0, 0.05)
	# 4. Death and Scene Management
	if health <= 0: 
		# Inside Healthcomponent.gd
		if get_parent().name == "Player":
			# Use the path to your menu scene
			get_tree().call_deferred("change_scene_to_file", "res://interface_1.tscn")
		else:
			var loot = xp_item_scene.instantiate()
			loot.global_position = get_parent().global_position
			get_tree().root.call_deferred("add_child", loot)
			var particles = parent.get_node_or_null("deathParticles")
			if particles:
				parent.remove_child(particles)
				particles.emitting = true
				get_tree().root.call_deferred("add_child", particles)
				particles.global_position = parent.global_position
			# Increment score in Global script before freeing the car
			Global.score += 10 
			get_parent().call_deferred("queue_free") 
