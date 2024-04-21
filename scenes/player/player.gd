extends CharacterBody2D

@export var gravity : float = 980
@export var jump_force : float = -400
signal morreu
var moving : bool = false

func _process(delta):
	aplicar_gravidade(delta)
	
	fly_player()


func aplicar_gravidade(delta : float):
	if moving:
		velocity.y += gravity * delta


func fly_player():
	if Input.is_action_just_pressed("jump"):
		moving = true
		velocity.y = jump_force
	
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	morreu.emit()
