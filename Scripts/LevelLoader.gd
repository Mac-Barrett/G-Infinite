extends Spatial

const gridSize = 60;
var startBlock

func load_racers():
    # Load player car data assigned by UI Menu
    var player = load("res://Vehicles/PlayerCar.tscn").instance()
    player.rotation.y = deg2rad(180)
    add_child(player)
    pass



func load_track_data():
    # Load from file assigned by UI Menu
    var data = [[11,2,12],[0,-1,1],[10,2,13]]
    return data



func load_track_pieces(data):
    for x in range(0, 3):
        for z in range(0, 3):
            # Load Piece from memory
            var trackPiece = load_piece(data[x][z])
            # If piece is not null, set transform
            if (trackPiece != null):
                trackPiece.transform.origin.x = float(gridSize * x)
                trackPiece.transform.origin.z = float(gridSize * z)
                add_child(trackPiece)
    pass


# Loads piece from memory, returns null if tpID is -1
func load_piece(tpID):
    var trackPiece = null
    match(tpID):
        0:
            trackPiece = load("res://TrackPieces/0.tscn").instance()
            startBlock = trackPiece
        1, 2:
            trackPiece = load("res://TrackPieces/1.tscn").instance()
            if (tpID == 2):
                trackPiece.rotation.y = deg2rad(90)
        10, 11, 12, 13:
            trackPiece = load("res://TrackPieces/10.tscn").instance()
            trackPiece.rotation.y = deg2rad(90 * (tpID - 10))
        -1:
            return trackPiece
    return trackPiece



func _ready():
    var trackData = load_track_data()
    load_track_pieces(trackData)
    load_racers()
    pass
