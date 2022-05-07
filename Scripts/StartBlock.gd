extends RigidBody

func _on_Area_body_entered(body):
    if body.is_in_group("Racer"):
        var castedRacer : Racer = body
        castedRacer._on_finish_line_crossed()
    pass
