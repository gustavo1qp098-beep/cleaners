extends PanelContainer

@onready var icone_item = $IconeItem
@onready var label_quantidade = $LabelQuantidade

func atualizar_slot(icone: Texture2D, quantidade: int):
	if icone != null:
		icone_item.texture = icone
		icone_item.show()
		label_quantidade.text = str(quantidade) if quantidade > 1 else ""
	else:
		icone_item.texture = null
		icone_item.hide()
		label_quantidade.text = ""
