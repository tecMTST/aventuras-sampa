tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("LabelTemporizada", "Label",  preload("LabelTemporizada.gd"), preload("icons/TimedLabel.svg"))

func _exit_tree():
	remove_custom_type("LabelTemporizada")
