extends Control

var trackData = []
var trackSize = 6

onready var track = get_node("TrackPanel/track")
onready var trackPieceSlot = load("res://Scenes/Menus/TrackBuilderTrackSlot.tscn")


func _ready():
    for x in range(0, trackSize):
        trackData.append([])
        for y in range(0, trackSize):
            trackData[x].append(-1)
            var tpSlot = trackPieceSlot.instance()
            track.add_child(tpSlot)
    #print(trackData)
    pass


# ----------------------------
# Button GUI
func _on_SaveTrack_pressed():
    pass


func _on_LoadTrack_pressed():
    pass


func _on_ClearTrack_pressed():
    pass


func _on_TestTrack_pressed():
    pass
