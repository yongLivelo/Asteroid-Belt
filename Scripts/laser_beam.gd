extends Node2D

signal activation(activating: bool, activated: bool)
@onready var collision: CollisionShape2D = $Line2D/DamageArea/CollisionShape2D
const MAX_RANGE = 5000
var base_width = 30
var is_laser_beam_cooldown: bool = false
var laser_beam_activating: bool = false
var laser_beam_activated: bool = false
var disabled: bool = false
var mouse_position: Vector2

func _ready():
	$Line2D.visible = false
	collision.disabled = true
	

func _physics_process(_delta):
	$Line2D.width = base_width
	if not laser_beam_activating:
		mouse_position = get_local_mouse_position()

	var max_cast_to = mouse_position.normalized() * MAX_RANGE
	$RayCast2D.target_position = max_cast_to
	if $RayCast2D.is_colliding():
		$Line2D.set_point_position(1, $Line2D.to_local($RayCast2D.get_collision_point()))
	else:
		$Line2D.points[1] = $RayCast2D.target_position
		collision.shape.b = $Line2D.points[1]

	if Input.is_action_just_pressed("beam") and not is_laser_beam_cooldown and not laser_beam_activated and not disabled:
		AudioManager.laser_beam.play()
		mouse_position = get_local_mouse_position()
		$HoldTime.start()
		laser_beam_activating = true
		activation.emit(laser_beam_activating, laser_beam_activated)

	if Input.is_action_just_released("beam") and not $Line2D.visible:
		AudioManager.laser_beam.stop()
		$HoldTime.stop()
		laser_beam_activating = false
		activation.emit(laser_beam_activating, laser_beam_activated)


func _on_hold_time_timeout():
	$Line2D.visible = true;
	collision.disabled = false;
	laser_beam_activating = true
	laser_beam_activated = true
	activation.emit(laser_beam_activating, laser_beam_activated)
	await get_tree().create_timer(1).timeout
	$Line2D.visible = false;
	collision.disabled = true;
	$Cooldown.start()
	laser_beam_activating = false
	laser_beam_activated = false
	activation.emit(laser_beam_activating, laser_beam_activated)
	is_laser_beam_cooldown = true


func _on_cooldown_timeout():
	is_laser_beam_cooldown = false


func _on_gas_manager_no_gas():
	disabled = true
