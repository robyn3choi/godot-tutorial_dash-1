extends Sprite

func _ready():
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.5, 3, 1)
	$Tween.start()
