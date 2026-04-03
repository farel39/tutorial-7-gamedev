extends RayCast3D

func _process(delta):
	var collider = get_collider()

	if is_colliding() and collider is Interactable:
		if Input.is_action_just_pressed("interact"):
			collider.interact(owner)
