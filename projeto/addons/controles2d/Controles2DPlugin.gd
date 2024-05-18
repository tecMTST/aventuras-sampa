tool
extends EditorPlugin

func _enter_tree():	 
	 add_custom_type("SideScrolling2D", "Controle2D",  preload("ControleSideScrolling2D.gd"), preload("icons/SideScroller2D.svg"))
	 add_custom_type("Pulo2D", "Controle2D",  preload("ControlePulo2D.gd"), preload("icons/Jump2D.svg"))
	 add_custom_type("TopDown2D", "Controle2D",  preload("ControleTopDown2D.gd"), preload("icons/TopDown2D.svg"))
	 add_custom_type("Controle2D", "Node2D",  preload("Controles2DBase.gd"), preload("icons/Base2D.svg"))

func _exit_tree():
	remove_custom_type("TopDown2D")
	remove_custom_type("Pulo2D")
	remove_custom_type("SideScrolling2D")
	remove_custom_type("Controle2D")
