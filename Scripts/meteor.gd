extends RigidBody2D

signal destroyed_meteor
signal destroyed_large_meteor
signal player_collision
signal laser_collision
var speed: int
var health: int
var size: String
var fractured: bool = false
var rng := RandomNumberGenerator.new()

func _ready():
	size = "large" if rng.randi_range(1, 5) == 1 && not fractured else "small"
	if size == "large":
		for node in get_children():
			node.scale = node.scale * 3
	$Sprite2D.texture = load("res://Assets/Graphics/Meteor/meteor_" + str(rng.randi_range(1, 3)) + ".png")
	if not fractured:
		var randomX: int = rng.randi_range(0, Global.width)
		var randomY: int = rng.randi_range(-50, -100)
		position = Vector2(randomX, randomY)
	
	linear_velocity = Vector2(rng.randi_range(-200, 200), rng.randi_range(500, 1000))


func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("laser"):
		AudioManager.meteor_destroy.play()
		laser_collision.emit()
		$Explode.emitting = true;
		$Sprite2D.visible = false
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		if size == "large":
			destroyed_large_meteor.emit(position)
		else:
			destroyed_meteor.emit(position)

	if area.is_in_group("laser_bullet"):
		area.queue_free()

	if area.is_in_group("object_clearer"):
		queue_free()


func _on_area_2d_body_entered(body: Node2D):
	
	if (body.is_in_group("player")):
		player_collision.emit(self)

func _on_explode_finished():
	queue_free()
