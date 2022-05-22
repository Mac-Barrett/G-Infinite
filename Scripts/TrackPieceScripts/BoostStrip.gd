extends RigidBody

var boostDirection : Vector3

func setBoostDirection(dir : Vector3):
    boostDirection = dir
    pass

func _on_BoostStrip_body_entered(body):
    if body.is_in_group("Racer"):
        var castedRacer : Racer = body
        castedRacer.boost_impulse(boostDirection * 40)
    pass
