extends Interactable

@export var item_name: String = "Kunci Rahasia"

func interact(body):
	# Cek apakah body yang berinteraksi (Player) punya fungsi add_item_to_inventory
	if body.has_method("add_item_to_inventory"):
		body.add_item_to_inventory(item_name)
		
		# Hancurkan objek dari dunia 3D setelah diambil
		queue_free()
