extends ParallaxBackground

@export var speed := 250.0

func _ready():
	# Make the layer loop by setting its motion mirror to the width
	# of the container.
	$ParallaxLayer.motion_mirroring.x = $ParallaxLayer/HBoxContainer.size.x


func _process(delta):
	scroll_offset.x -= delta * speed

