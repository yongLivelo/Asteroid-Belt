extends Node2D

var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")

func _on_meteor_timer_timeout():
	instansiate_meteor()

func instansiate_meteor():
	var meteor = meteor_scene.instantiate()
	add_child(meteor)
	meteor.player_collision.connect($"../Player".on_meteor_collision)
	meteor.destroyed_large_meteor.connect(create_fractures)x
	return meteor
	
func create_fractures(pos: Vector2):
	for i in range(2):
		var fracture = instansiate_meteor()
		fracture.position = pos
		fracture.fractured = true


func increment_speed_meteor_timer():
	$MeteorTimer.wait_time -= 0.001