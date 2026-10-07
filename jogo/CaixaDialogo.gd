extends Control

@onready var label_nome = $Panel/NomeNPC
@onready var label_texto = $Panel/TextoDialogo
@onready var botao_avancar = $Panel/BotaoAvancar

var missao_pendente: MissaoData = null

func _ready():
	hide() # Começa invisível
	botao_avancar.pressed.connect(_on_botao_pressionado)

func exibir_dialogo(nome_npc: String, texto: String, missao: MissaoData = null):
	label_nome.text = nome_npc
	label_texto.text = texto
	missao_pendente = missao
	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE # Libera o cursor para clicar no botão

func _on_botao_pressionado():
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Trava a câmera em primeira pessoa de novo
	
	if missao_pendente != null:
		MissionManager.aceitar_missao(missao_pendente)
		missao_pendente = null
