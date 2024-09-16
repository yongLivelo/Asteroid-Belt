extends CharacterBody2D

@export var speed: int = 800
@export var acceleration: int = 50
@export var friction_value: int = 10
const MAX_HEALTH: int = 5
var health = MAX_HEALTH
var is_hit_cooldown: bool = false
var freeze: bool = false
var mouse_position: Vector2

func _ready():
	$Camera2D.limit_right = Global.width
	$Camera2D.limit_bottom = Global.height

	
func _physics_process(_delta):
	var direction = Vector2.ZERO

	if not freeze:
		direction = Input.get_vector("left", "right", "up", "down")
		mouse_position = get_global_mouse_position()
		look_at(mouse_position)

	if direction != Vector2.ZERO:
		accelerate(direction)
	else:
		friction()
		
	move_and_slide()
		

func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acceleration)
	

func friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction_value)


func on_meteor_collision(body: RigidBody2D):

	AudioManager.player_damage.play()
	velocity = -((body.linear_velocity - velocity) * 1.5)

	if not is_hit_cooldown:
		is_hit_cooldown = true
		health -= 1
		$AnimationPlayer.play("player_hit")
		get_tree().call_group('user_interface', 'set_health', health)
		if health <= 0:
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")
			AudioManager.background_normal.stop()
	await $AnimationPlayer.animation_finished
	is_hit_cooldown = false


func _on_laser_beam_activation(activating: bool, activated: bool):
	freeze = activating
	
	if activated:
		velocity = -(transform.x * 2000)


func _on_gas_manager_no_gas():
	freeze = true
