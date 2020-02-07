extends KinematicBody2D

export var max_speed_default: = Vector2(200.0, 0.0)
export var max_idle_time: = 11

onready var timer: = get_node("Idle_Cooldown")
onready var anim_player: = get_node("Skin/AnimationPlayer")
onready var sprite: = get_node("Skin/Sprite")
onready var sound_player: AudioStreamPlayer = get_node("Sounds/AudioStreamPlayer")
	
const FLOOR_NORMAL: = Vector2.UP

var max_speed: = max_speed_default
var velocity: = Vector2.ZERO
var enemy_idle = false
var idle_time: = 0

func _ready() -> void:
	anim_player.play("Enemy_Move")

func _physics_process(delta: float) -> void:
	velocity = max_speed_default
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	set_idle_time()
	set_facing_direction()
	if !sound_player.is_playing() and abs(velocity.x) > 0:
		sound_player.play()
	
func set_idle_time() -> void:
	if velocity.x == 0 and !enemy_idle:
		anim_player.play("Enemy_Idle")
		idle_time = randi() % max_idle_time + 1
		timer.wait_time = idle_time
		timer.start()
		enemy_idle = true

func set_facing_direction():
	if velocity.x > 0:
		sprite.scale.x = 1
	elif velocity.x < 0:
		sprite.scale.x = -1

func _on_Idle_Cooldown_timeout() -> void:
	anim_player.play("Enemy_Move")
	max_speed_default *= -1
	enemy_idle = false


func _on_Attack_Range_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.die()

func freeze() -> void:
	set_physics_process(false)
