extends ParallaxBackground

var StarScene: PackedScene = load("res://scenes/star.tscn")

func _ready():
	for parallax_layer in get_children():
		if parallax_layer.name == "BackgroundColor":
			continue
		for n in 50:
			var star = StarScene.instantiate()
			parallax_layer.add_child(star)

func _process(delta):
	scroll_base_offset.y += 300 * delta
