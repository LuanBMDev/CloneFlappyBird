extends Node

@export var speed : float = 600
var random_pos_y : float
signal addPontos
signal morreu

func _ready():
	pass 


func _process(delta):
	mover_cano(delta)


func mover_cano(delta : float):
	self.position.x -= speed * delta


func _on_cano_1_body_entered(body):
	if body.is_in_group("Player"):
		morreu.emit()


func _on_cano_2_body_entered(body):
	if body.is_in_group("Player"):
		morreu.emit()


func _on_area_ponto_body_entered(body):
	if body.is_in_group("Player"):
		addPontos.emit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
