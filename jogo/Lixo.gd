extends Area3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	# Aceita se o jogador estiver no grupo "Player" ou se o nó tiver "player" no nome
	if body.is_in_group("Player") or "Player" in body.name or "player" in body.name:
		if GameManager:
			GameManager.adicionar_progresso(1) # Soma 1 na missão
		queue_free() # Remove o lixo do mapa
