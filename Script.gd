extends Node2D

export (int) var force = 1

const slot_offsets = [
	Vector2(-150, -60),
	Vector2(0, -150),
	Vector2(150, -60),
]
var text_display = "here is some text to show"
var display_offset: Vector2 = Vector2()

var ready = false
var progress: float = 0.0
export (float) var complete_at: float = 1.0
var using = false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

func init(slot):
	display_offset = slot_offsets[slot]
	$Display.position = display_offset
	set_text_progress()
	ready = true

func stop_and_reset():
	progress = 0
	using = false

func start_use():
	using = true

func pause_use():
	var using = false

func reset():
	progress = 0

func stop_use():
	if progress >= complete_at:
		complete()
	else:
		stop_and_reset()

func complete():
	stop_and_reset()

func set_text_progress():
	var total_chars = text_display.length()
	var complete_percent = progress/complete_at
	var show_chars = int(total_chars * complete_percent)
	$Display/TextProgress.text = text_display.substr(0, show_chars)

func _physics_process(delta):
	if using:
		progress += delta
	set_text_progress()
