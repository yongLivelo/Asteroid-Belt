extends CanvasLayer

@onready var score_display: Label = $CenterContainer/VBoxContainer/ScoreDisplay

func _ready():
	score_display.text = "YOUR SCORE:  " + str(Global.score)


func _input(event):
	if event.is_action_pressed("bullet"):
			get_tree().change_scene_to_file("res://Scenes/level.tscn")
