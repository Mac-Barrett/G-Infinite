extends Control

onready var tp0 : Image = load("res://Textures/Icons/0.jpg")
onready var tp1 : Image = load("res://Textures/Icons/1.jpg")
onready var tp10 : Image= load("res://Textures/Icons/10.jpg")

var imgCycle = [-1, 0, 1, 2, 10, 11, 12, 13]

var trackData = [[]]

func _ready():
    for x in range(0, 6):
        for y in range(0, 6):
            trackData[x][y] = -1
            var btn = TextureButton.new()
            
            var img = Image.new()
            var imgText = ImageTexture.new()
            
            img = load("res://Textures/Icons/0.jpg")
            imgText.create_from_image(img)
            
            btn.texture_normal = imgText
            btn.connect("pressed", self, "_button_pressed", [btn])
            $track.add_child(btn)
    pass
    
func _button_pressed(btn):
    var img = Image.new()
    var imgText = ImageTexture.new()
                
    img = tp10
    imgText.create_from_image(img)
    
    btn.texture_normal = imgText
    pass
