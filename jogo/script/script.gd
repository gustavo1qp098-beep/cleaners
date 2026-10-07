extends CharacterBody3D
 
@export var walk_speed := 7.0         # Ajustado para uma velocidade realista
@export var run_speed := 11.0         # Ajustado para uma velocidade realista
@export var jump_velocity := 20.0      # CORRIGIDO: Pulo calibrado (200 faria o boneco sumir da tela)
@export var mouse_sensitivity := 0.002
 
@onready var head = $Head
 
var gravity := 9.8
var pitch := 0.0
 
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
 
func _input(event):
	if event is InputEventMouseMotion:
		# Rotação horizontal (Olhar para os lados)
		rotate_y(-event.relative.x * mouse_sensitivity)
 
		# Rotação vertical BLINDADA (Usa a função nativa do Godot para inclinar)
		head.rotate_x(event.relative.y * mouse_sensitivity)
		
		# Força o limite de olhar para não dar uma cambalhota (Garante que trava em 80 graus)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))


 
func _physics_process(delta):
	# Aplica Gravidade normal se não estiver no chão
	if not is_on_floor():
		velocity.y -= gravity * delta
 
	# Pulo corrigido usando a tecla Espaço
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = jump_velocity
 
	# Sistema de Corrida (Shift)
	var current_speed = walk_speed
	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = run_speed
 
	# Captura os comandos das teclas WASD CORRIGIDOS (Alinhados com o padrão 3D do Godot)
	var input_dir = Vector2.ZERO
	if Input.is_key_pressed(KEY_S): input_dir.y -= 1.0 # Frente no Godot 3D é -Z
	if Input.is_key_pressed(KEY_W): input_dir.y += 1.0 # Trás no Godot 3D é +Z
	if Input.is_key_pressed(KEY_D): input_dir.x -= 1.0 # Esquerda no Godot 3D é -X
	if Input.is_key_pressed(KEY_A): input_dir.x += 1.0 # Direita no Godot 3D é +X
 
	# Calcula a direção correta baseado para onde a sua câmera está olhando
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
 
	# Aplica os vetores de velocidade horizontal com suavidade
	if direction != Vector3.ZERO:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
 
	move_and_slide()
