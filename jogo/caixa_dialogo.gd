extends Control

@onready var panel: Panel = $Panel
@onready var nome_npc_label: Label = $Panel/NomeNPC
@onready var texto_dialogo_label: Label = $Panel/TextoDialogo
@onready var botao_avancar: Button = $Panel/BotaoAvancar

func _ready() -> void:
	panel.hide()
	if botao_avancar:
		if not botao_avancar.pressed.is_connected(_on_botao_avancar_pressed):
			botao_avancar.pressed.connect(_on_botao_avancar_pressed)

func exibir_dialogo(nome: String, texto: String) -> void:
	nome_npc_label.text = nome
	texto_dialogo_label.text = texto
	panel.show()
	if GameManager:
		GameManager.travar_jogador(true)

func _on_botao_avancar_pressed() -> void:
	panel.hide()
	if GameManager:
		GameManager.travar_jogador(false)
