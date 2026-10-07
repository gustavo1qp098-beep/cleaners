extends Control

@export var slot_scene: PackedScene # Arraste a cena slot_item.tscn para ca no Inspetor
@export var total_slots: int = 36 # 3 linhas de 12 slots

@onready var grade_slots = $PanelContainer/GradeSlots

var slots_instanciados: Array = []

func _ready():
	hide() # Garante que o inventario comeca invisivel ao iniciar o jogo
	_gerar_grade()

func _unhandled_input(event):
	# Captura o toque no TAB
	if event.is_action_pressed("ui_focus_next"):
		if visible:
			fechar_inventario()
		else:
			abrir_inventario()

func abrir_inventario():
	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE # Solta o ponteiro do mouse

func fechar_inventario():
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Trava a camera 3D novamente

func _gerar_grade():
	if slot_scene == null:
		print("ERRO: Arraste a cena slot_item.tscn para o campo Slot Scene no Inspetor!")
		return
		
	for i in range(total_slots):
		var novo_slot = slot_scene.instantiate()
		grade_slots.add_child(novo_slot)
		slots_instanciados.append(novo_slot)

func atualizar_grade(itens_array: Array):
	for i in range(total_slots):
		if i < itens_array.size() and itens_array[i] != null:
			slots_instanciados[i].atualizar_slot(itens_array[i].icone, itens_array[i].quantidade)
		else:
			slots_instanciados[i].atualizar_slot(null, 0)
