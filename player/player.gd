extends CharacterBody2D

@export var speed = 90
@export var jump_strength = 105
@export var mass = 1
@export var acceleration = .25
@export var friction = .25
@export var roll_speed = 180
@export var dead_touch : bool = true # testing purpose

@onready var facing_marker = $FacingMarker
@onready var anim = $AnimatedSprite2D
@onready var ray_cast_2d = $RayCast2D
@onready var jump_sound = $Node2D/Jump
@onready var collision_shape_2d = $CollisionShape2D
@onready var panel_closed_timer = $LevelSelectPanelClosed
@onready var trailing_particle: CPUParticles2D = $TrailingParticle

enum {NORMAL, DIE, WIN, UI_SELECT}
var facing_right : bool
var state = NORMAL
var jumped_once = false
var on_air_time = 0

# Stage select
#var inside_door = false
#var door_id = 0
@export var edge_check = true

func _ready():
	Messenger.player_change_to_win_state.connect(func(): state = WIN)
	Messenger.player_selecting_level.connect(func(): state = UI_SELECT)
	Messenger.player_stop_selecting_level.connect(func(): panel_closed_timer.start())
	facing_right = (facing_marker.global_position.x - global_position.x) > 0


func _physics_process(delta):
	match state:
		NORMAL:
			_normal_state(delta)
		DIE:
			_die_state()
		WIN:
			_win_state()
		UI_SELECT:
			_ui_select_state()

func _die_state():
	collision_shape_2d.set_deferred("disabled", true)
	anim.play("die")

func _change_to_win_state():
	state = WIN

func _win_state():
	pass

func _ui_select_state():
	pass

func _normal_state(delta):
	velocity.y += Settings.current_gravity * delta
	velocity.y = min(velocity.y, Settings.gravity_limit)

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

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_strength
		jumped_once = true
		jump_sound.play()
		#collision_shape_2d.position.y = 0.5

	if is_on_floor() and dir == 0:
		anim.play("idle")
	elif is_on_floor() and dir != 0:
		anim.play("run")
	elif not is_on_floor():
		anim.play("jump")

	if jumped_once and not is_on_floor():
		on_air_time += delta

	# DIE
	if dead_touch:
		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider().is_in_group("Platform") \
			and jumped_once \
			and on_air_time > 0.1:
				die()


	#if is_on_floor() and jumped_once and on_air_time > 0.1 and dead_touch:
		#Messenger.player_forbidden_touch.emit()

	if is_on_floor() and not ray_cast_2d.is_colliding() and edge_check:
		velocity.x = 0

	move_and_slide()

func die():
	Messenger.player_forbidden_touch.emit()
	state = DIE

func _on_level_select_panel_closed_timeout():
	state = NORMAL
