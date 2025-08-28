extends Node

const cena_carros = preload("res://Cenas/carros.tscn")
var pistas_rapidas_y = [104, 272, 488]
var pistas_lentas_y = [160, 216, 324, 368, 438, 544, 600]
var score = 0

func _ready():
	$hud/placar.text = str(score)
	$hud/mensagem.text = ""
	$hud/Button.hide()
	$audioTema.play()
	randomize()

func _on_timer_carros_rapidos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)
	
	var pista_y = pistas_rapidas_y[randi_range(0, pistas_rapidas_y.size() - 1)]
	carro.position = Vector2(-10, pista_y)
	carro.set_linear_velocity(Vector2(randi_range(700, 710), 0))
	carro.set_linear_damp(0.0)
	
func _on_timer_carros_lentos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)
	
	var pista_y = pistas_lentas_y[randi_range(0, pistas_lentas_y.size() - 1)]
	carro.position = Vector2(-10, pista_y)
	carro.set_linear_velocity(Vector2(randi_range(300, 310), 0))
	carro.set_linear_damp(0.0)
	 
func _on_player_pontua() -> void:
	if score <= 10:
		score += 1
		$hud/placar.text = str(score)
		$audioPonto.play()
		$player.position = $player.posicao_inicial
	if score == 10:
		$hud/mensagem.show()
		$hud/button.show()
		$timerCarrosRapidos.stop()
		$timerCarrosLentos.stop()
		$audioTema.stop()
		$audioVitoria.play()
		$player.speed = 0

func _on_hud_reinicia() -> void:
	score = 0
	$hud/mensagem.hide()
	$hud/placar.text = str(score)
	$hud/button.hide()
	$timerCarrosRapidos.start()
	$timerCarrosLentos.start()
	$audioTema.play()
