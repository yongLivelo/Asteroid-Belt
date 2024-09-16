extends Node2D

var LaserBulletScene: PackedScene = load("res://scenes/laser_bullet.tscn")
var is_laser_bullet_cooldown: bool = false
var disabled
func _physics_process(_delta):
	if not disabled:
		if Input.is_action_just_pressed("bullet") and !is_laser_bullet_cooldown:
				shoot_laser_bullet()
				is_laser_bullet_cooldown = true
				await get_tree().create_timer(0.2).timeout
				is_laser_bullet_cooldown = false
			

func shoot_laser_bullet():
	var mouse_position = get_global_mouse_position()
	var laser = LaserBulletScene.instantiate()
	laser.position = get_parent().position
	laser.direction = mouse_position
	add_child(laser)


func _on_laser_beam_activation(activating: bool, _activated):
	disabled = activating


func _on_gas_manager_no_gas():
	disabled = true
