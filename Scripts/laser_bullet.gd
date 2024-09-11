extends Area2D

@export var speed: int = 1000
var direction: Vector2

func _ready():
	look_at(direction)
	AudioManager.laser_bullet.play()
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(0.1, 0.1), 0.5).from(Vector2(0.05, 0.05))


func _process(delta):
	position += transform.x * delta * speed
