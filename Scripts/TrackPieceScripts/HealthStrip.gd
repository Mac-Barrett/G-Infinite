extends RigidBody


func _on_Area_body_entered(body):
    if body.is_in_group("Racer"):
        var castedRacer : Racer = body
        castedRacer.set_isHealing(true)
    pass


func _on_Area_body_exited(body):
    if body.is_in_group("Racer"):
        var castedRacer : Racer = body
        castedRacer.set_isHealing(false)
    pass
    
