extends CanvasLayer

onready var tween_logo: Tween = $TweenLogo
onready var logo: Control = $Logo
onready var botao_menu: CanvasLayer = $Logo/BotaoMenufeed

func _ready():
	tween_logo.interpolate_property(logo, "rect_position",  Vector2(0, -50), Vector2(0, 0), 0.6, Tween.TRANS_LINEAR)
	tween_logo.interpolate_property(botao_menu, "offset",  Vector2(0, -50), Vector2(0, 0), 0.6, Tween.TRANS_LINEAR)
	tween_logo.start()
