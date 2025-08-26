extends Area2D

signal pontua

@export var speed: float = 100.0
@export var run_speed: float = 200.0
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2(640,690)


func _ready() -> void:
	screen_size =get_viewport_rect().size
	position = posicao_inicial

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):         #mover a galinha para cima
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):       #mover a galinha para baixo
		velocity.y += 1
	if Input.is_action_pressed("ui_right"):
		velocity.x +=1
	if Input.is_action_pressed("ui_left"):
		velocity.x -=1
	if Input.is_action_pressed("run"):
		speed = run_speed
		
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed
		
		position += velocity * delta
		position.y = clamp(position.y, 0.0, screen_size.y)
		
		
	if velocity.y > 0:
		$animacao.play("baixo")
	elif velocity.y < 0:
		$animacao.play("cima")
	else:
		$animacao.stop()





func _on_body_entered(body):
	if body.name == "linhachegada":
		emit_signal("pontua")
		
	else:
		$audio.play()
		position = posicao_inicial
