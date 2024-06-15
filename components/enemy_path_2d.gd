extends Path2D

@export var remote_node : Node2D
@export var speed : float # progress ratio

@onready var path_follow_2d = $PathFollow2D

func _ready():
	$PathFollow2D/RemoteTransform2D.remote_path = remote_node.get_path()

func _process(delta):
	path_follow_2d.progress_ratio += speed * delta
