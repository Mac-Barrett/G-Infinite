extends TextureRect

func get_drag_data(position):
    var data = {
        "texture": texture,
        "textureID" : name,
        "flip_h" : flip_h,
        "flip_v" : flip_v
        }
    
    var dragTexture = TextureRect.new()
    dragTexture.expand = true
    dragTexture.texture = texture
    dragTexture.flip_h = flip_h
    dragTexture.flip_v = flip_v
    dragTexture.rect_size = Vector2(60, 60)
    
    var dragControl = Control.new()
    dragControl.add_child(dragTexture)
    dragTexture.rect_position = -0.5 * dragTexture.rect_size
    set_drag_preview(dragControl)
    
    return data
    
func can_drop_data(position, data):
    return false
