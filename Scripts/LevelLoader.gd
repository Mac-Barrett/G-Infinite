extends Spatial

const gridSize = 60;
var trackData = []
var racers = []

var startBlock
var checkPoints = []
var cpID_index = 0

# Called by parent while instancing this scene
func set_trackData(td):
    trackData = td.duplicate()
    pass


# Once scene is instanced...
func _enter_tree():
    # trackData = load_track_data().duplicate()
    load_track_pieces(trackData)
    load_racers()
    connect_events()
    pass


# LOAD TRACK ---------------------------------------------------
# Uses data array to load in trackpieces and place them in world
func load_track_pieces(data):
    for x in range(0, data.size()):
        for z in range(0, data[x].size()):
            # Load Piece from memory
            var trackPiece = load_piece(data[x][z])
            # If piece is not null, set transform
            if (trackPiece != null):
                trackPiece.transform.origin.x = float(-gridSize * x)
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
        3, 4: 
            trackPiece = load("res://TrackPieces/3.tscn").instance()
            if (tpID == 4):
                trackPiece.rotation.y = deg2rad(90)
            trackPiece.set_checkpointID(cpID_index)
            cpID_index += 1
            checkPoints.append(trackPiece)
        10, 11, 12, 13:
            trackPiece = load("res://TrackPieces/10.tscn").instance()
            trackPiece.rotation.y = deg2rad(90 * (tpID - 10))
        20, 21, 22, 23:
            trackPiece = load("res://TrackPieces/20.tscn").instance()
            trackPiece.rotation.y = deg2rad(90 * (tpID - 20))
        24, 25:
            trackPiece = load("res://TrackPieces/24.tscn").instance()
            trackPiece.rotation.y = deg2rad(180 * (tpID - 24))
        -1:
            return trackPiece
    return trackPiece


# LOAD RACERS & EVENTS -----------------------------------------
# Loads racers and places them in world space
func load_racers():
    # Load player car data assigned by UI Menu
    var player : KinematicBody = load("res://Vehicles/PlayerCar.tscn").instance()
    player.transform.origin.x = startBlock.transform.origin.x
    player.transform.origin.z = startBlock.transform.origin.z
    player.rotation.y = deg2rad(180)
    
    player.set_numCheckpoints(cpID_index)
    player.add_to_group("Racer")
    racers.append(player)
    add_child(player)
    pass


# Connects racers to events
# Going so see if this isn't needed
func connect_events():
    for r in range(0, racers.size()):
        startBlock.connect("finish_line_crossed", racers[r], "_on_finish_line_crossed")
        for c in range(0, checkPoints.size()):
            checkPoints[c].connect("checkpoint_crossed", racers[r], "_on_checkpoint_crossed")
    pass


# For hardcoding & testing
func load_track_data():
    # Load from file assigned by UI Menu
    # var data = [[11,2,12],[0,-1,1],[10,2,13]] # square track
    var data = [[11, 2, 2, 12], 
                [10, 12, 11, 13], 
                [-1, 1, 0, -1], 
                [-1, 10, 13, -1]] # more complex track
    return data

