extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var duck_timer = $DuckTimer
@onready var collision = $Collision
@onready var duck_collision = $DuckCollision

const JUMP_VELOCITY = -250.0

func _ready() -> void:
	duck_collision.disabled = true
	animated_sprite_2d.play("default")

func _physics_process(delta):
	if not is_on_floor():
		_add_gravity(delta)
	elif Input.is_action_just_pressed("ui_up"):
		_handle_jump()
	elif Input.is_action_just_pressed("ui_down"):
		_handle_duck()
	
	move_and_slide()

func _add_gravity(delta) -> void:
	velocity += get_gravity() * delta
	
func _handle_jump() -> void:
	velocity.y = JUMP_VELOCITY

func _handle_duck():
	collision.disabled = true
	duck_collision.disabled = false
	animated_sprite_2d.play("duck")
	duck_timer.start()

func _on_duck_timer_timeout():
	collision.disabled = false
	duck_collision.disabled = true
	animated_sprite_2d.play("run")
