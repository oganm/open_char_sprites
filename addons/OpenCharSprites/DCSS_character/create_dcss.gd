tool
extends EditorScript

func list_files_in_directory(path, ends_with = '')->Array:
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") && file.ends_with(ends_with):
			files.append(file)
	dir.list_dir_end()
	return files


var asset_dir = 'res://addons/OpenCharSprites/DCSS_character/player/'


func _run():
	
	print('var asset_dir = "' + asset_dir + '"\n')
	
	
	var dirs = list_files_in_directory(asset_dir)
	for x in dirs:
		var files = list_files_in_directory(asset_dir+x,'.png')
		var definition = 'export(String,""'
		for y in files:
			definition = definition + ', "' + y.get_basename() + '"'
		
		definition = definition + ")  var " + x + " setget set_" + x
		print(definition)
	
	print('\n')
	
	for x in dirs:
		var setter = 'func set_' + x + "(_"+ x + "):\n\t" + x + " = _" + x + "\n"
		setter = setter + "\tif " + x +' != "":\n' 
		setter = setter + "\t\tget_node('" + x.capitalize() + "').texture = load(asset_dir + '/" + x + "/' + "+ x + "+'.png')\n"
		setter = setter + "\telse:\n\t\tget_node('" + x.capitalize() + "').texture = null"
		print(setter)
	
	
	
