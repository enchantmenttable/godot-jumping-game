extends CharacterBody2D

@export var speed = 90
@export var jump_strength = 170
@export var mass = 1
@export var acceleration = .25
@export var friction = .25
@export var roll_speed = 180
@export var dead_touch : bool = true # testing purpose

@onready var facing_marker = $FacingMarker
@onready var anim = $AnimatedSprite2D
@onready var receive_box_collision_shape = $ReceiveBox/CollisionShape2D
@onready var ray_cast_2d = $RayCast2D

enum {NORMAL}
var gravity_limit = 700
var health = PlayerData.health
var facing_right : bool
var airtime = 0.0
var coyote_time = 0.08
var roll_time = 0.0
var jumping = false
var state = NORMAL
var jumped_once = false
var on_air_time = 0

func _ready():
	facing_right = (facing_marker.global_position.x - global_position.x) > 0

func _physics_process(delta):
	match state:
		NORMAL:
			_normal_state(delta)

#MOVEMENT
func _normal_state(delta):
	velocity.y += Settings.custom_gravity * delta
	velocity.y = min(velocity.y, gravity_limit)

	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		if dir > 0 and not facing_right:
			scale.x = -1
			facing_right = true
		elif dir < 0 and facing_right:
			scale.x = -1
			facing_right = false
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	if is_on_floor():
		airtime = 0.0
		jumping = false
	else:
		airtime += delta

	if Input.is_action_just_pressed("jump") and not jumping and airtime < coyote_time:
		velocity.y = -jump_strength
		jumping = true
		jumped_once = true

	if is_on_floor() and dir == 0:
		anim.play("idle")
	elif is_on_floor() and dir != 0:
		anim.play("run")
	elif not is_on_floor():
		anim.play("jump")

	if jumped_once and not is_on_floor():
		on_air_time += delta

	if is_on_floor() and jumped_once and on_air_time > 0.1 and dead_touch:
		Messenger.player_forbidden_touch.emit()

	if not jumping and not ray_cast_2d.is_colliding():
		velocity.x = 0

	move_and_slide()
