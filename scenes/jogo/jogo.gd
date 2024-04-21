extends Node2D

var random_pos_y : float
@export var cena_canos : PackedScene
var pontos : int

func _ready():
	new_game()
	$Player.morreu.connect(game_over)


func _on_spawn_timer_timeout():
	if $Player.moving:
		gerar_cano()


func gerar_cano():
	random_pos_y = randf_range(-130, 140)
	var cano = cena_canos.instantiate()
	
	cano.morreu.connect(game_over)
	cano.addPontos.connect(incrementarPontuacao)
	cano.position = Vector2(1414, random_pos_y)
	
	add_child(cano)


func incrementarPontuacao():
	pontos += 1
	$HUD/Pontuacao.text = str(pontos)


func game_over():
	# Fazer tela de game over
	$SpawnTimer.stop()
	$Player.moving = false
	get_tree().paused = true
	$HUD/TelaGameOver.visible = true

func new_game():
	$HUD/TelaGameOver.visible = false
	get_tree().paused = false
	pontos = 0
	$HUD/Pontuacao.text = str(pontos)
	get_tree().call_group("Canos", "queue_free")
	$Player.position = $StartPosition.position
	$Player.velocity.y = 0
	$SpawnTimer.start()


func _on_btn_restart_pressed():
	new_game()


func _on_btn_sair_pressed():
	get_tree().quit()
