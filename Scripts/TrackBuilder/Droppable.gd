extends TextureRect

onready var root = get_parent().get_parent().get_parent().get_parent()
const gridTotalSize : Vector2 = Vector2(400, 400)
var gridPos = Vector2()


func set_gridPos(pos):
    gridPos = pos
    pass


func set_texture_on_load(data):
    texture = data["texture"]
    flip_h = data["flip_h"]
    flip_v = data["flip_v"]
    var cols = data["trackSize"]
    rect_size.x = (gridTotalSize.x / cols) - 4
    rect_size.y = (gridTotalSize.y / cols) - 4
    pass


func drop_data(position, data):
    texture = data["texture"]
    flip_h = data["flip_h"]
    flip_v = data["flip_v"]
    root.callv("update_trackData", [gridPos, data["textureID"]])
    pass
    

func can_drop_data(position, data):
    return true
