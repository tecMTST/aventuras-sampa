class_name GeradorObjeto
## Adaptado de [https://github.com/uheartbeast/Galaxy-Defiance/blob/main/components/spawner_component.gd]
extends EditorPlugin

export var objeto: PackedScene


## Gera objeto no local dado, e insere como crianca do responsavel
func gerar(local: Vector2, responsavel: Node) -> PackedScene:
	assert(objeto is PackedScene, 'Sem objeto para instanciar.')
	var novo_objeto = objeto.instance()
	responsavel.add_child(novo_objeto)
	novo_objeto.global_position = local
	return novo_objeto
