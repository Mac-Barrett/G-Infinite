extends TextureRect

onready var root = get_parent().get_parent().get_parent().get_parent()

var gridPos = Vector2()

func set_gridPos(pos):
    gridPos = pos
    pass


func drop_data(position, data):
    texture = data["texture"]
    flip_h = data["flip_h"]
    flip_v = data["flip_v"]
    root.callv("update_trackData", [gridPos, data["textureID"]])
    pass
    

func can_drop_data(position, data):
    return true
