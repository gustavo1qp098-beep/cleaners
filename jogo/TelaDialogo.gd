extends CanvasLayer

@onready var label_nome: Label = $CaixaDialogo/MarginContainer/VBoxContainer/LabelNome
@onready var label_texto: RichTextLabel = $CaixaDialogo/MarginContainer/VBoxContainer/LabelTexto
@onready var caixa_dialogo: PanelContainer = $CaixaDialogo

@export var velocidade_digitação: float = 0.03

func _ready() -> void:
	caixa_dialogo.visible = false

func exibir_dialogo(nome_npc: String, texto: String) -> void:
	label_nome.text = nome_npc
	label_texto.text = texto
	label_texto.visible_characters = 0
	caixa_dialogo.visible = true
	
	# Animação do texto surgindo letra por letra
	var tween = create_tween()
	var tempo_total = texto.length() * velocidade_digitação
	tween.tween_property(label_texto, "visible_ratio", 1.0, tempo_total)

func fechar_dialogo() -> void:
	caixa_dialogo.visible = false
