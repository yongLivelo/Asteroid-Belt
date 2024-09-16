extends Node2D

var meteor_scene: PackedScene = load("res://Scenes/meteor.tscn")

func _on_meteor_timer_timeout():
	var meteor = instansiate_meteor()
	add_child(meteor)

func instansiate_meteor():
	var meteor = meteor_scene.instantiate()
	meteor.player_collision.connect($"../Player".on_meteor_collision)
	meteor.destroyed_large_meteor.connect(create_fractures)
	meteor.destroyed_meteor.connect($"../Player/GasManager".leave_gas)
	return meteor
	
func create_fractures(pos: Vector2):
	for i in range(2):
		var fracture = instansiate_meteor()
		fracture.position = pos
		fracture.fractured = true
		add_child(fracture)


func increment_speed_meteor_timer():
	if $MeteorTimer.wait_time > 0.1:
		$MeteorTimer.wait_time -= 0.001
