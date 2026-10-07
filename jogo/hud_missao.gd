extends Control

@onready var label_progresso: Label = $PanelContainer/LabelProgresso if has_node("PanelContainer/LabelProgresso") else null

func _ready() -> void:
	hide()
	
	if not label_progresso:
		label_progresso = find_child("LabelProgresso", true, false) as Label

	if GameManager:
		GameManager.missao_atualizada.connect(_on_missao_atualizada)

func _on_missao_atualizada(id: int, progresso: int, total: int) -> void:
	# Se a missão for 0 ou total for 0, esconde o HUD da tela
	if id == 0 or total == 0:
		hide()
		return
		
	show()
	
	if label_progresso:
		if progresso < total:
			label_progresso.text = "Missão %d\nObjetivo: %d/%d" % [id, progresso, total]
		else:
			label_progresso.text = "Missão %d\nConcluída! Volte ao NPC." % id
