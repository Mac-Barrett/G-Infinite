extends Spatial

const gridSize = 60;


func load_racers():
    # Load player car data assigned by UI Menu
    var player = load("res://Objects/PlayerCar.tscn").instance()
    add_child(player)
    pass



func load_track_data():
    # Load from file assigned by UI Menu
    var data = [[1,1,1],[0,0,0],[1,1,1]]
    return data



func load_track_pieces(data):
    for x in range(0, 3):
        for z in range(0, 3):
            var trackPiece = null
            # INSTEAD OF SWITCH:
            #   all finished roadpieces will simply have a filename
            #   of a number from 0 - 128 and will be loaded by adding the number
            #   from the data array that was parsed to the path
            match(data[x][z]):
                0:
                    trackPiece = load("res://Objects/Road1.tscn").instance()
                1:
                    trackPiece = load("res://Objects/Turn1.tscn").instance()
            trackPiece.transform.origin.x = float(gridSize * x)
            trackPiece.transform.origin.z = float(gridSize * z)
            add_child(trackPiece)
    pass



func _ready():
    load_racers()
    var trackData = load_track_data()
    load_track_pieces(trackData)
    pass
