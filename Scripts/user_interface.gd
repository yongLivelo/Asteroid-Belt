extends CanvasLayer

@onready var fps_label: Label = $FPS/Label
var health_image: Texture2D = load("res://Assets/Graphics/player.png")
var time_elapsed: int = 0

func set_health(amount):
	for child in $Health/HBoxContainer.get_children():
		child.queue_free()
	
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = health_image
		text_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		$Health/HBoxContainer.add_child(text_rect)


func set_gas(amount):
	var tween = create_tween()
	tween.tween_property($Gas/ProgressBar, 'value', amount, 0.2).from($Gas/ProgressBar.value)


func _on_score_timer_timeout():
	get_tree().call_group("level", "increment_speed_meteor_timer")
	time_elapsed += 1
	$Score/Value.text = str(time_elapsed)
	Global.score = time_elapsed


func _process(delta):
	fps_label.text = str(Engine.get_frames_per_second()) + "fps"
