extends Area2D

signal gas_absorb
var overlap: bool = false
var speed: int = 400

func _process(delta):
	position += Vector2(0, 200) * delta
	if overlap:
		var player = $Vicinity.get_overlapping_bodies()[0]
		position = position.move_toward(player.position, speed * delta)

func _on_vicinity_body_entered(_body):
	overlap = true

func _on_vicinity_body_exited(_body):
	overlap = false

func _on_body_entered(body):
	gas_absorb.emit()
	queue_free()