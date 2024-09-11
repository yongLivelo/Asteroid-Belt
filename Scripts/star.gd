extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	var randomX: int = rng.randi_range(0, Global.width)
	var randomY: int = rng.randi_range(0, Global.height)
	position = Vector2(randomX, randomY)
	var randomSize = rng.randf_range(0.4, 1)
	scale = Vector2(randomSize, randomSize)
	$AnimationPlayer.speed_scale = rng.randf_range(0.5, 1.2)
	$AnimationPlayer.play("shining")


func _on_visible_on_screen_notifier_2d_screen_exited():
	$AnimationPlayer.pause()


func _on_visible_on_screen_notifier_2d_screen_entered():
	$AnimationPlayer.play("shining")
