extends Node

var pasta : String = "user://saves"

func salvar(id, chave, valor):
	var atual = carregar_tudo(id)
	if not atual:
		atual = SaveFile.new()
		atual.Id = id
	atual.Data = Time.get_date_string_from_system(true)
	atual.Dados[chave] = valor
	var dict = {"Id": atual.Id, "Data": atual.Data, "Dados": atual.Dados}
	var novo_save = JSON.print(dict)
	var file_name = pasta + "/" + id + ".sav"
	var file = File.new()
	file.open(file_name, File.WRITE)
	file.store_string(novo_save)
	file.close()
	
func carregar(id , chave):
	var atual = carregar_tudo(id)
	if not atual:
		return null
	if not atual.Dados.has(chave):
		return null
	return atual.Dados[chave]
	
func existe(id , chave):
	var atual = carregar_tudo(id)
	if not atual:
		return false
	if not atual.Dados.has(chave):
		return false
	return true
	
func carregar_tudo(id) -> SaveFile:
	_verificar_pasta()
	var file_name = pasta + "/" + id + ".sav"
	var file = File.new()
	var err = file.open(file_name, File.READ)
	if err == OK: 
		var conteudo = file.get_as_text()	
		var json_data = JSON.parse(conteudo)
		if json_data.error == OK and typeof(json_data.result) == TYPE_DICTIONARY:
			var save = SaveFile.new()
			save.Id = json_data.result["Id"]
			save.Data = json_data.result["Data"]
			save.Dados = json_data.result["Dados"]
			return save
	return null
	
func listar_saves() -> Array:
	var dir = _verificar_pasta()	
	var arquivos = []
	dir.open(pasta)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir():
			var save_file = SaveFile.new()
			save_file.Id = file_name.replace(".sav", "")
			save_file.Data = Time.get_datetime_string_from_unix_time(File.new().get_modified_time(pasta + "/" + file_name))
			arquivos.append(save_file)
		file_name = dir.get_next()	
	return arquivos

func _verificar_pasta() -> Directory:
	var dir  = Directory.new()
	if not dir.dir_exists(pasta):
		dir.make_dir(pasta)
	return dir;
