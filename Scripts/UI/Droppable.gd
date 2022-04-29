extends TextureRect

func drop_data(position, data):
    texture = data["texture"]
    flip_h = data["flip_h"]
    flip_v = data["flip_v"]
    pass

func can_drop_data(position, data):
    return true
