#01. @tool
@tool
#02. class_name

#03. extends
extends EditorScript
#04. # docstring

## VX, MV, MZ方式のA1,A2,A4のタイルマップ画像をGodotで使用できる方式へ画像コンバートします。
## その後、コンバートした画像を使用したTileSetリソースを作成します。

#region Signal, Enum, Const

#-----------------------------------------------------------
#07. constants
#-----------------------------------------------------------

## 対象ディレクトリ
const TARGET_DIR = "res://sprite/"
## 出力先ディレクトリ
## 画像出力先ディレクトリ
const OUTPUT_SPRITE_DIR = "res://output_sprite/"
## タイルセット出力先ディレクトリ
const OUTPUT_TILESET_DIR = "res://tileset/"

## アニメーションのフレーム数
const ANIMATION_DURATION:float = 1.0

##
const TERRAIN_BITMASKS_TENKEY = [
	[[1,2,3,4,5,6,7,8,9],[  2,3,4,5,6,7,8,9],[1,2,  4,5,6,7,8,9],[  2,  4,5,6,7,8,9],[1,2,3,4,5,6,7,8, ],[  2,3,4,5,6,7,8, ]],
	[[1,2,  4,5,6,7,8, ],[  2,  4,5,6,7,8, ],[1,2,3,4,5,6,  8,9],[  2,3,4,5,6,  8,9],[1,2,  4,5,6,  8,9],[  2,  4,5,6,  8,9]],
	[[1,2,3,4,5,6,  8, ],[  2,3,4,5,6,  8, ],[1,2,  4,5,6,  8, ],[  2,  4,5,6,  8, ],[  2,3,  5,6,  8,9],[  2,    5,6,  8,9]],
	[[  2,3,  5,6,  8, ],[  2,    5,6,  8, ],[      4,5,6,7,8,9],[      4,5,6,7,8, ],[      4,5,6,  8,9],[      4,5,6,  8, ]],
	[[1,2,  4,5,  7,8, ],[1,2,  4,5,    8, ],[  2,  4,5,  7,8, ],[  2,  4,5,    8, ],[1,2,3,4,5,6,     ],[  2,3,4,5,6,     ]],
	[[1,2,  4,5,6,     ],[  2,  4,5,6,     ],[  2,    5,    8  ],[      4,5,6      ],[        5,6,  8,9],[        5,6,  8  ]],
	[[      4,5,  7,8, ],[      4,5,    8, ],[1,2,  4,5        ],[  2,  4,5        ],[  2,3,  5,6,     ],[  2,    5,6,     ]],
	[[        5,    8  ],[      5,6        ],[  2,    5        ],[      4,5        ],[        5        ],[                 ]],
]

const TERRAIN_BITMASKS_TENKEY_A3 = [
	[[        5,6,  8,9],[      4,5,6,7,8,9],[      4,5,  7,8  ],[        5,    8  ],[                 ],[                 ]],
	[[  2,3,  5,6,  8,9],[1,2,3,4,5,6,7,8,9],[1,2,  4,5,  7,8, ],[  2,    5,    8  ],[                 ],[                 ]],
	[[  2,3,  5,6,     ],[1,2,3,4,5,6,     ],[1,2,  4,5,       ],[  2,    5        ],[                 ],[                 ]],
	[[        5,6,     ],[      4,5,6      ],[      4,5,       ],[        5        ],[                 ],[                 ]],
]

const TERRAIN_BITMASKS__TENKEY_WATERFALL = [
	[[        5,6,     ],[      4,5,6      ],[      4,5,       ],[        5        ],[                 ],[                 ]],
	[[        5,6,     ],[      4,5,6      ],[      4,5,       ],[        5        ],[                 ],[                 ]],
	[[        5,6,     ],[      4,5,6      ],[      4,5,       ],[        5        ],[                 ],[                 ]],
]

const TERRAIN_BITMASKS_TENKEY_A4 = [
	[[1,2,3,4,5,6,7,8,9],[  2,3,4,5,6,7,8,9],[1,2,  4,5,6,7,8,9],[  2,  4,5,6,7,8,9],[1,2,3,4,5,6,7,8, ],[  2,3,4,5,6,7,8, ]],
	[[1,2,  4,5,6,7,8, ],[  2,  4,5,6,7,8, ],[1,2,3,4,5,6,  8,9],[  2,3,4,5,6,  8,9],[1,2,  4,5,6,  8,9],[  2,  4,5,6,  8,9]],
	[[1,2,3,4,5,6,  8, ],[  2,3,4,5,6,  8, ],[1,2,  4,5,6,  8, ],[  2,  4,5,6,  8, ],[  2,3,  5,6,  8,9],[  2,    5,6,  8,9]],
	[[  2,3,  5,6,  8, ],[  2,    5,6,  8, ],[      4,5,6,7,8,9],[      4,5,6,7,8, ],[      4,5,6,  8,9],[      4,5,6,  8, ]],
	[[1,2,  4,5,  7,8, ],[1,2,  4,5,    8, ],[  2,  4,5,  7,8, ],[  2,  4,5,    8, ],[1,2,3,4,5,6,     ],[  2,3,4,5,6,     ]],
	[[1,2,  4,5,6,     ],[  2,  4,5,6,     ],[  2,    5,    8  ],[      4,5,6      ],[        5,6,  8,9],[        5,6,  8  ]],
	[[      4,5,  7,8, ],[      4,5,    8, ],[1,2,  4,5        ],[  2,  4,5        ],[  2,3,  5,6,     ],[  2,    5,6,     ]],
	[[        5,    8  ],[      5,6        ],[  2,    5        ],[      4,5        ],[        5        ],[                 ]],
	
	[[        5,6,  8,9],[      4,5,6,7,8,9],[      4,5,  7,8  ],[        5,    8  ],[                 ],[                 ]],
	[[  2,3,  5,6,  8,9],[1,2,3,4,5,6,7,8,9],[1,2,  4,5,  7,8, ],[  2,    5,    8  ],[                 ],[                 ]],
	[[  2,3,  5,6,     ],[1,2,3,4,5,6,     ],[1,2,  4,5,       ],[  2,    5        ],[                 ],[                 ]],
	[[        5,6,     ],[      4,5,6      ],[      4,5,       ],[        5        ],[                 ],[                 ]],
]

#endregion
#-----------------------------------------------------------

#region Variable

#-----------------------------------------------------------
#10. private variables
#-----------------------------------------------------------

#endregion
#-----------------------------------------------------------

#region _virtual Function
#-----------------------------------------------------------
#14. remaining built-in virtual methods
#-----------------------------------------------------------

func _run() -> void:
	reference()
	
	if !DirAccess.dir_exists_absolute(OUTPUT_SPRITE_DIR):
			DirAccess.make_dir_recursive_absolute(OUTPUT_SPRITE_DIR)
	if !DirAccess.dir_exists_absolute(OUTPUT_TILESET_DIR):
			DirAccess.make_dir_recursive_absolute(OUTPUT_TILESET_DIR)
	await create_dummy_sprites()
	
	# A1の変換
	convert_a1()
	
	# A2の変換
	convert_a2()
	
	# A3の変換
	convert_a3()
	
	# A4の変換
	convert_a4()
	
	EditorInterface.get_resource_filesystem().scan()
	
	await EditorInterface.get_resource_filesystem().filesystem_changed
	
	unreference()

#endregion
#-----------------------------------------------------------

#region _private Function
#-----------------------------------------------------------
#16. private methods
#-----------------------------------------------------------

func create_dummy_sprites():
	var a1_image_paths:= get_target_autotile_image_file_paths("_A1")
	for image_path in a1_image_paths:
		var imagefilename:String = image_path.get_basename().split("/")[-1]
		if !FileAccess.file_exists(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png")):
			var tmp_image:= Image.create(1, 1,false, Image.FORMAT_RGBA8)
			tmp_image.save_png(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
	var a2_image_paths:= get_target_autotile_image_file_paths("_A2")
	for image_path in a2_image_paths:
		var imagefilename:String = image_path.get_basename().split("/")[-1]
		if !FileAccess.file_exists(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png")):
			var tmp_image:= Image.create(1, 1,false, Image.FORMAT_RGBA8)
			tmp_image.save_png(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
	var a3_image_paths:= get_target_autotile_image_file_paths("_A3")
	for image_path in a3_image_paths:
		var imagefilename:String = image_path.get_basename().split("/")[-1]
		if !FileAccess.file_exists(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png")):
			var tmp_image:= Image.create(1, 1,false, Image.FORMAT_RGBA8)
			tmp_image.save_png(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
	var a4_image_paths:= get_target_autotile_image_file_paths("_A4")
	for image_path in a4_image_paths:
		var imagefilename:String = image_path.get_basename().split("/")[-1]
		if !FileAccess.file_exists(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png")):
			var tmp_image:= Image.create(1, 1,false, Image.FORMAT_RGBA8)
			tmp_image.save_png(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		
	await EditorInterface.get_base_control().get_tree().process_frame
		
	EditorInterface.get_resource_filesystem().scan()
	
	await EditorInterface.get_resource_filesystem().filesystem_changed
	
	await EditorInterface.get_base_control().get_tree().create_timer(1.0)

func convert_a1() -> void:
	var a2_image_paths:= get_target_autotile_image_file_paths("_A1")
	for image_path in a2_image_paths:
		var imagefilename:String = image_path.get_basename().split("/")[-1]
		var image:= Image.load_from_file(image_path)
		
		## VXかMVか判定
		var is_mv:bool = image.get_width() == 768
		
		var tilesize:int = 48 if is_mv else 32
		var org_section_size:Vector2i = Vector2i(tilesize * 2, tilesize * 3)
		var out_section_size:Vector2i = Vector2i(tilesize * 6, tilesize * 8)
		
		# タイルセット作成
		var tileset:TileSet = TileSet.new()
		
		tileset.add_terrain_set(0)
		tileset.set_terrain_set_mode(0, TileSet.TERRAIN_MODE_MATCH_CORNERS_AND_SIDES)
		tileset.tile_size = Vector2i(tilesize, tilesize)
		
		var tileset_src:TileSetAtlasSource = TileSetAtlasSource.new()
		# 一時的に透明ピクセルの画像をセットする（Atlas範囲外って言われるので）
		tileset_src.texture = ImageTexture.create_from_image(Image.create(tilesize * 6 * 8, tilesize * 8 * 4,false, image.get_format()))
		tileset.add_source(tileset_src)
		tileset_src.texture_region_size = Vector2i(tilesize, tilesize)
		
		## 6マスの1セットとしてまとめる。
		var section_images:Array[Image] = []
		var final_image:Image = null
		var terrain_index:int = 0
		for row in 4:
			var row_image:Image = null
			for col in 8:
				## アニメの空のファイル
				var is_anime_empty_tile = (col == 1)\
				or (col == 2)\
				or (col == 5)\
				or (col == 6)
				
				# 滝タイル
				var is_waterfall_tile:= (row == 2 and col == 3)\
					or (row == 3 and col == 3)\
					or (row == 0 and col == 7)\
					or (row == 1 and col == 7)\
					or (row == 2 and col == 7)\
					or (row == 3 and col == 7)
				
				if is_waterfall_tile:
					var clipped_image:Image = Image.create(org_section_size.x,org_section_size.y,false,image.get_format())
					clipped_image.blit_rect(image, Rect2i(col * org_section_size.x, row * org_section_size.y, tilesize * 4, tilesize * 3), Vector2i.ZERO)
					var waterfall_image:= conv_maker_waterfall(clipped_image, tilesize)
					
					var out_image:= Image.create(out_section_size.x,out_section_size.y,false,image.get_format())
					out_image.blit_rect(waterfall_image,Rect2i(Vector2i.ZERO,waterfall_image.get_size()),Vector2i.ZERO)
					# Terrainを作成する 1パレットになるので1セクション1つになる
					# clipped_imageのY座標がtilesize / 2のピクセルカラーをすべて取得し、平均色を算出する。
					var colors:Array[Color] = []
					for x in org_section_size.x:
						for y in org_section_size.x:
							colors.append(clipped_image.get_pixel(x, y))
					
					var avg_color:Color = Color(0, 0, 0, 0)
					for color in colors:
						avg_color += color
					avg_color /= colors.size()
					avg_color.a = 1.0
					colors = []
					
					tileset.add_terrain(0)
					tileset.set_terrain_color(0, terrain_index, avg_color)
					tileset.set_terrain_name(0, terrain_index, "autotile_" + str(row) + "_" + str(col))
					
					# タイルを作成する
					for y in 1:
						for x in 4:
							#全部1マス
							var pos:=Vector2i((out_section_size.x / tilesize) * col + x,(out_section_size.y / tilesize) * row + y)
							
							tileset_src.create_tile(pos)
							# 地形を塗る
							var tile_data:TileData = tileset_src.get_tile_data(pos,0)
							
							tileset_src.set_tile_animation_columns(pos,1)
							tileset_src.set_tile_animation_frames_count(pos,3)
							tileset_src.set_tile_animation_separation(pos,Vector2i(0,0))
							tileset_src.set_tile_animation_frame_duration(pos,0, ANIMATION_DURATION)
							tileset_src.set_tile_animation_frame_duration(pos,1, ANIMATION_DURATION)
							tileset_src.set_tile_animation_frame_duration(pos,2, ANIMATION_DURATION)
							
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(1)\
							or TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(2)\
							or TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(3)\
							or TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(4)\
							or TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(5)\
							or TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(6)\
							or TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(7)\
							or TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(8)\
							or TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x].has(9)
							)\
							:
								tile_data.terrain_set = 0
								tile_data.terrain = terrain_index
							# テンキーで対応するところをビットマスクする
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(1):
								tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER, terrain_index)
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(2):
								tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_SIDE, terrain_index)
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(3):
								tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER, terrain_index)
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(4):
								tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_LEFT_SIDE, terrain_index)
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(5):
								tile_data.terrain_set = 0
								tile_data.terrain = terrain_index
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(6):
								tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_RIGHT_SIDE, terrain_index)
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(7):
								tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER, terrain_index)
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(8):
								tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_SIDE, terrain_index)
							if (TERRAIN_BITMASKS__TENKEY_WATERFALL[y][x] as Array).has(9):
								tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER, terrain_index)
					terrain_index += 1
					if row_image == null:
						row_image = out_image
					else:
						row_image = concat_image_right(row_image, out_image)
					
					continue
				
				
				var clipped_image:Image = Image.create(org_section_size.x,org_section_size.y,false,image.get_format())
				clipped_image.blit_rect(image, Rect2i(col * org_section_size.x, row * org_section_size.y, org_section_size.x, org_section_size.y), Vector2i.ZERO)
				var out_image:= conv_maker(clipped_image, tilesize)
				
				# Terrainを作成する 1パレットになるので1セクション1つになる
				
				# clipped_imageのY座標がtilesize / 2のピクセルカラーをすべて取得し、平均色を算出する。
				var colors:Array[Color] = []
				for x in org_section_size.x:
					for y in org_section_size.x:
						colors.append(clipped_image.get_pixel(x, y))
				
				var avg_color:Color = Color(0, 0, 0, 0)
				for color in colors:
					avg_color += color
				avg_color /= colors.size()
				avg_color.a = 1.0
				colors = []
				
				if !is_anime_empty_tile: 
					tileset.add_terrain(0)
					tileset.set_terrain_color(0, terrain_index, avg_color)
					tileset.set_terrain_name(0, terrain_index, "autotile_" + str(row) + "_" + str(col))
				
				# (0,3),(1,3)のよくわからんタイルは滝ではないが動きもしない
				var is_yokuwakaran_tile:= (row == 0 and col == 3) or (row == 1 and col == 3)
				
				# タイルを作成する
				for y in 8:
					for x in 6:
						if is_anime_empty_tile: continue
						
						#全部1マス
						var pos:=Vector2i((out_section_size.x / tilesize) * col + x,(out_section_size.y / tilesize) * row + y)
						
						#print(pos)
						tileset_src.create_tile(pos)
						# 地形を塗る
						var tile_data:TileData = tileset_src.get_tile_data(pos,0)
						
						if !is_yokuwakaran_tile:
							tileset_src.set_tile_animation_separation(pos,Vector2i(5,0))
							tileset_src.set_tile_animation_columns(pos,3)
							tileset_src.set_tile_animation_frames_count(pos,3)
							tileset_src.set_tile_animation_frame_duration(pos,0, ANIMATION_DURATION)
							tileset_src.set_tile_animation_frame_duration(pos,1, ANIMATION_DURATION)
							tileset_src.set_tile_animation_frame_duration(pos,2, ANIMATION_DURATION)
						
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x].has(1)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(2)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(3)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(4)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(5)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(6)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(7)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(8)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(9)
						)\
						:
							tile_data.terrain_set = 0
							tile_data.terrain = terrain_index
						# テンキーで対応するところをビットマスクする
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(1):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(2):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(3):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(4):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_LEFT_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(5):
							tile_data.terrain_set = 0
							tile_data.terrain = terrain_index
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(6):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_RIGHT_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(7):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(8):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(9):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER, terrain_index)
				if !is_anime_empty_tile:
					terrain_index += 1
				if row_image == null:
					row_image = out_image
				else:
					row_image = concat_image_right(row_image, out_image)
			if final_image == null:
				final_image = row_image
			else:
				final_image = concat_image_bottom(final_image, row_image)
		final_image.save_png(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		
		var loaded_texture:= load(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		tileset_src.texture = loaded_texture
		
		# TODO 2行で1ファイルにしようかな
		#
		#for section_image in section_images:
			#
		ResourceSaver.save(tileset, OUTPUT_TILESET_DIR.path_join(imagefilename + ".tres"))
	pass

func convert_a2() -> void:
	var a2_image_paths:= get_target_autotile_image_file_paths("_A2")
	for image_path in a2_image_paths:
		var imagefilename:String = image_path.get_basename().split("/")[-1]
		var image:= Image.load_from_file(image_path)
		
		## VXかMVか判定
		var is_mv:bool = image.get_width() == 768
		
		var tilesize:int = 48 if is_mv else 32
		var org_section_size:Vector2i = Vector2i(tilesize * 2, tilesize * 3)
		var out_section_size:Vector2i = Vector2i(tilesize * 6, tilesize * 8)
		
		# タイルセット作成
		var tileset:TileSet = TileSet.new()
		
		tileset.add_terrain_set(0)
		tileset.set_terrain_set_mode(0, TileSet.TERRAIN_MODE_MATCH_CORNERS_AND_SIDES)
		tileset.tile_size = Vector2i(tilesize, tilesize)
		
		var tileset_src:TileSetAtlasSource = TileSetAtlasSource.new()
		# 一時的に透明ピクセルの画像をセットする（Atlas範囲外って言われるので）
		tileset_src.texture = ImageTexture.create_from_image(Image.create(tilesize * 6 * 8, tilesize * 8 * 4,false, image.get_format()))
		tileset.add_source(tileset_src)
		tileset_src.texture_region_size = Vector2i(tilesize, tilesize)
		
		## 6マスの1セットとしてまとめる。
		var section_images:Array[Image] = []
		var final_image:Image = null
		var terrain_index:int = 0
		for row in 4:
			var row_image:Image = null
			for col in 8:
				var clipped_image:Image = Image.create(org_section_size.x,org_section_size.y,false,image.get_format())
				clipped_image.blit_rect(image, Rect2i(col * org_section_size.x, row * org_section_size.y, org_section_size.x, org_section_size.y), Vector2i.ZERO)
				var out_image:= conv_maker(clipped_image, tilesize)
				
				# Terrainを作成する 1パレットになるので1セクション1つになる
				
				# clipped_imageのY座標がtilesize / 2のピクセルカラーをすべて取得し、平均色を算出する。
				var colors:Array[Color] = []
				for x in org_section_size.x:
					for y in org_section_size.x:
						colors.append(clipped_image.get_pixel(x, y))
				
				var avg_color:Color = Color(0, 0, 0, 0)
				for color in colors:
					avg_color += color
				avg_color /= colors.size()
				avg_color.a = 1.0
				colors = []
				
				tileset.add_terrain(0)
				tileset.set_terrain_color(0, terrain_index, avg_color)
				tileset.set_terrain_name(0, terrain_index, "autotile_" + str(row) + "_" + str(col))
				
				
				# タイルを作成する
				for y in 8:
					for x in 6:
						#全部1マス
						var pos:=Vector2i((out_section_size.x / tilesize) * col + x,(out_section_size.y / tilesize) * row + y)
						#print(pos)
						tileset_src.create_tile(pos)
						# 地形を塗る
						var tile_data:TileData = tileset_src.get_tile_data(pos,0)
						
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x].has(1)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(2)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(3)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(4)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(5)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(6)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(7)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(8)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(9)
						)\
						:
							tile_data.terrain_set = 0
							tile_data.terrain = terrain_index
						# テンキーで対応するところをビットマスクする
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(1):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(2):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(3):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(4):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_LEFT_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(5):
							tile_data.terrain_set = 0
							tile_data.terrain = terrain_index
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(6):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_RIGHT_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(7):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(8):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY[y][x] as Array).has(9):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER, terrain_index)
				terrain_index += 1
				if row_image == null:
					row_image = out_image
				else:
					row_image = concat_image_right(row_image, out_image)
			if final_image == null:
				final_image = row_image
			else:
				final_image = concat_image_bottom(final_image, row_image)
		final_image.save_png(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		
		var loaded_texture:= load(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		tileset_src.texture = loaded_texture
		
		# TODO 2行で1ファイルにしようかな
		#
		#for section_image in section_images:
			#
		ResourceSaver.save(tileset, OUTPUT_TILESET_DIR.path_join(imagefilename + ".tres"))
	pass

func convert_a3() -> void:
	var a3_image_paths:= get_target_autotile_image_file_paths("_A3")
	for image_path in a3_image_paths:
		var imagefilename:String = image_path.get_basename().split("/")[-1]
		var image:= Image.load_from_file(image_path)
		
		## VXかMVか判定
		var is_mv:bool = image.get_width() == 768
		
		var tilesize:int = 48 if is_mv else 32
		var org_section_size:Vector2i = Vector2i(tilesize * 2, tilesize * 2)
		var out_section_size:Vector2i = Vector2i(tilesize * 4, tilesize * 4)
		
		# タイルセット作成
		var tileset:TileSet = TileSet.new()
		
		tileset.add_terrain_set(0)
		tileset.set_terrain_set_mode(0, TileSet.TERRAIN_MODE_MATCH_CORNERS_AND_SIDES)
		tileset.tile_size = Vector2i(tilesize, tilesize)
		
		var tileset_src:TileSetAtlasSource = TileSetAtlasSource.new()
		# 一時的に透明ピクセルの画像をセットする（Atlas範囲外って言われるので）
		var tmp_image:= Image.create(tilesize * 6 * 8, tilesize * 8 * 4,false, image.get_format())
		var tex:ImageTexture = ImageTexture.create_from_image(tmp_image)

		tileset_src.texture = tex
		tileset.add_source(tileset_src)
		tileset_src.texture_region_size = Vector2i(tilesize, tilesize)
		
		## 4マスの1セットとしてまとめる。
		var section_images:Array[Image] = []
		var final_image:Image = null
		var terrain_index:int = 0
		for row in 4:
			var row_image:Image = null
			for col in 8:
				var clipped_image:Image = Image.create(org_section_size.x,org_section_size.y,false,image.get_format())
				clipped_image.blit_rect(image, Rect2i(col * org_section_size.x, row * org_section_size.y, org_section_size.x, org_section_size.y), Vector2i.ZERO)
				var out_image:= conv_maker_a3(clipped_image, tilesize)
				
				# Terrainを作成する 1パレットになるので1セクション1つになる
				
				# clipped_imageのY座標がtilesize / 2のピクセルカラーをすべて取得し、平均色を算出する。
				var colors:Array[Color] = []
				for x in org_section_size.x:
					for y in org_section_size.x:
						colors.append(clipped_image.get_pixel(x, y))
				
				var avg_color:Color = Color(0, 0, 0, 0)
				for color in colors:
					avg_color += color
				avg_color /= colors.size()
				avg_color.a = 1.0
				colors = []
				
				tileset.add_terrain(0)
				tileset.set_terrain_color(0, terrain_index, avg_color)
				tileset.set_terrain_name(0, terrain_index, "autotile_" + str(row) + "_" + str(col))
				
				
				# タイルを作成する
				for y in 4:
					for x in 4:
						#全部1マス
						var pos:=Vector2i((out_section_size.x / tilesize) * col + x,(out_section_size.y / tilesize) * row + y)
						#print(pos)
						tileset_src.create_tile(pos)
						# 地形を塗る
						var tile_data:TileData = tileset_src.get_tile_data(pos,0)
						
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x].has(1)\
						or TERRAIN_BITMASKS_TENKEY_A3[y][x].has(2)\
						or TERRAIN_BITMASKS_TENKEY_A3[y][x].has(3)\
						or TERRAIN_BITMASKS_TENKEY_A3[y][x].has(4)\
						or TERRAIN_BITMASKS_TENKEY_A3[y][x].has(5)\
						or TERRAIN_BITMASKS_TENKEY_A3[y][x].has(6)\
						or TERRAIN_BITMASKS_TENKEY_A3[y][x].has(7)\
						or TERRAIN_BITMASKS_TENKEY_A3[y][x].has(8)\
						or TERRAIN_BITMASKS_TENKEY_A3[y][x].has(9)
						)\
						:
							tile_data.terrain_set = 0
							tile_data.terrain = terrain_index
						# テンキーで対応するところをビットマスクする
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(1):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(2):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(3):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(4):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_LEFT_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(5):
							tile_data.terrain_set = 0
							tile_data.terrain = terrain_index
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(6):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_RIGHT_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(7):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(8):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_SIDE, terrain_index)
						if (TERRAIN_BITMASKS_TENKEY_A3[y][x] as Array).has(9):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER, terrain_index)
				terrain_index += 1
				if row_image == null:
					row_image = out_image
				else:
					row_image = concat_image_right(row_image, out_image)
			if final_image == null:
				final_image = row_image
			else:
				final_image = concat_image_bottom(final_image, row_image)
		final_image.save_png(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		
		#print(ResourceLoader.get_recognized_extensions_for_type(".png"))
		#EditorInterface.get_base_control().set_meta("batch_tkool_tile_importer", self)
		#await EditorInterface.get_resource_filesystem().filesystem_changed
		var loaded_texture:= ResourceLoader.load(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		tileset_src.texture = loaded_texture
		
		# TODO 2行で1ファイルにしようかな
		#
		#for section_image in section_images:
			#
		ResourceSaver.save(tileset, OUTPUT_TILESET_DIR.path_join(imagefilename + ".tres"))

func convert_a4() -> void:
	var a2_image_paths:= get_target_autotile_image_file_paths("_A4")
	for image_path in a2_image_paths:
		var imagefilename:String = image_path.get_basename().split("/")[-1]
		var image:= Image.load_from_file(image_path)
		
		## VXかMVか判定
		var is_mv:bool = image.get_width() == 768
		
		var tilesize:int = 48 if is_mv else 32
		var org_section_size:Vector2i = Vector2i(tilesize * 2, tilesize * 5)
		var out_section_size:Vector2i = Vector2i(tilesize * 6, tilesize * 12)
		#print(org_section_size)
		#print(out_section_size)
		
		# タイルセット作成
		var tileset:TileSet = TileSet.new()
		
		tileset.add_terrain_set(0)
		tileset.set_terrain_set_mode(0, TileSet.TERRAIN_MODE_MATCH_CORNERS_AND_SIDES)
		tileset.tile_size = Vector2i(tilesize, tilesize)
		
		var tileset_src:TileSetAtlasSource = TileSetAtlasSource.new()
		# 一時的に透明ピクセルの画像をセットする（Atlas範囲外って言われるので）
		tileset_src.texture = ImageTexture.create_from_image(Image.create(tilesize * 6 * 8, tilesize * 12 * 3,false,image.get_format()))#TODO
		tileset.add_source(tileset_src)
		tileset_src.texture_region_size = Vector2i(tilesize, tilesize)
		
		## 10マスの1セットとしてまとめる。
		var section_images:Array[Image] = []
		var final_image:Image = null
		var terrain_index:int = 0
		for row in 3:
			var row_image:Image = null
			for col in 8:
				var clipped_image:Image = Image.create(org_section_size.x,org_section_size.y,false,image.get_format())
				clipped_image.blit_rect(image, Rect2i(col * org_section_size.x, row * org_section_size.y, org_section_size.x, org_section_size.y), Vector2i.ZERO)
				var out_image:= conv_maker(clipped_image, tilesize)
				
				var out_image_4cell:= conv_maker_a4(clipped_image, tilesize)
				out_image = concat_image_bottom(out_image, out_image_4cell)
				
				# Terrainを作成する 1パレットになるので1セクション1つになる
				
				# clipped_imageのY座標がtilesize / 2のピクセルカラーをすべて取得し、平均色を算出する。
				var colors:Array[Color] = []
				for x in org_section_size.x:
					for y in org_section_size.x:
						colors.append(clipped_image.get_pixel(x, y))
				
				var avg_color:Color = Color(0, 0, 0, 0)
				for color in colors:
					avg_color += color
				avg_color /= colors.size()
				avg_color.a = 1.0
				colors = []
				
				tileset.add_terrain(0)
				tileset.set_terrain_color(0, terrain_index, avg_color)
				tileset.set_terrain_name(0, terrain_index, "autotile_" + str(row) + "_" + str(col))
				
				for x in org_section_size.x:
					for y in org_section_size.x:
						colors.append(clipped_image.get_pixel(x, y))
				
				avg_color = Color(0, 0, 0, 0)
				for color in colors:
					avg_color += color
				avg_color /= colors.size()
				avg_color.a = 1.0
				colors = []
				tileset.add_terrain(0)
				tileset.set_terrain_color(0, terrain_index + 1, avg_color)
				tileset.set_terrain_name(0, terrain_index + 1, "autotile_" + str(row) + "_" + str(col) + "_wall")
				
				# タイルを作成する
				var terrain_kabe:int= 0
				for y in 12:
					if y == 8 and terrain_kabe == 0:
						terrain_kabe = 1
					for x in 6:
						#全部1マス
						var pos:=Vector2i((out_section_size.x / tilesize) * col + x,(out_section_size.y / tilesize) * row + y)
						#print(pos)
						tileset_src.create_tile(pos)
						# 地形を塗る
						var tile_data:TileData = tileset_src.get_tile_data(pos,0)
						
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x].has(1)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(2)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(3)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(4)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(5)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(6)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(7)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(8)\
						or TERRAIN_BITMASKS_TENKEY_A4[y][x].has(9)
						)\
						:
							tile_data.terrain_set = 0
							tile_data.terrain = terrain_index + terrain_kabe
						
						# テンキーで対応するところをビットマスクする
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(1):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER, terrain_index + terrain_kabe)
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(2):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_SIDE, terrain_index + terrain_kabe)
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(3):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER, terrain_index + terrain_kabe)
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(4):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_LEFT_SIDE, terrain_index + terrain_kabe)
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(5):
							tile_data.terrain_set = 0
							tile_data.terrain = terrain_index + terrain_kabe
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(6):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_RIGHT_SIDE, terrain_index + terrain_kabe)
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(7):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER, terrain_index + terrain_kabe)
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(8):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_SIDE, terrain_index + terrain_kabe)
						if (TERRAIN_BITMASKS_TENKEY_A4[y][x] as Array).has(9):
							tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER, terrain_index + terrain_kabe)
				terrain_index += 2
				if row_image == null:
					row_image = out_image
				else:
					row_image = concat_image_right(row_image, out_image)
			if final_image == null:
				final_image = row_image
			else:
				final_image = concat_image_bottom(final_image, row_image)
		final_image.save_png(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		
		var loaded_texture:= load(OUTPUT_SPRITE_DIR.path_join(imagefilename + ".png"))
		tileset_src.texture = loaded_texture
		
		ResourceSaver.save(tileset, OUTPUT_TILESET_DIR.path_join(imagefilename + ".tres"))


func get_target_autotile_image_file_paths(target_type:String) -> Array[String]:
	var filenames:= DirAccess.get_files_at(TARGET_DIR)
	var resary:Array[String] = []
	for filename in filenames:
		if filename.to_upper().contains(target_type)\
		and !(filename.ends_with(".import")):
			resary.append(TARGET_DIR.path_join(filename))
	return resary
#endregion
#-----------------------------------------------------------

#func conv_wolf(tex:Texture) -> Image:
	#if tex == null:return null
	## ウディタタイプ
	#var i1a_at = AtlasTexture.new()
	#var i1b_at = AtlasTexture.new()
	#var i1c_at = AtlasTexture.new()
	#var i1d_at = AtlasTexture.new()
	#var i2a_at = AtlasTexture.new()
	#var i2b_at = AtlasTexture.new()
	#var i2c_at = AtlasTexture.new()
	#var i2d_at = AtlasTexture.new()
	#var i3a_at = AtlasTexture.new()
	#var i3b_at = AtlasTexture.new()
	#var i3c_at = AtlasTexture.new()
	#var i3d_at = AtlasTexture.new()
	#var i4a_at = AtlasTexture.new()
	#var i4b_at = AtlasTexture.new()
	#var i4c_at = AtlasTexture.new()
	#var i4d_at = AtlasTexture.new()
	#var i5a_at = AtlasTexture.new()
	#var i5b_at = AtlasTexture.new()
	#var i5c_at = AtlasTexture.new()
	#var i5d_at = AtlasTexture.new()
	#i1a_at.atlas = tex
	#i1b_at.atlas = tex
	#i1c_at.atlas = tex
	#i1d_at.atlas = tex
	#i2a_at.atlas = tex
	#i2b_at.atlas = tex
	#i2c_at.atlas = tex
	#i2d_at.atlas = tex
	#i3a_at.atlas = tex
	#i3b_at.atlas = tex
	#i3c_at.atlas = tex
	#i3d_at.atlas = tex
	#i4a_at.atlas = tex
	#i4b_at.atlas = tex
	#i4c_at.atlas = tex
	#i4d_at.atlas = tex
	#i5a_at.atlas = tex
	#i5b_at.atlas = tex
	#i5c_at.atlas = tex
	#i5d_at.atlas = tex
	## 1 = 島
	## 1A 1B
	## 1C 1D
	#i1a_at.region = Rect2(0,0,HalfCellSize,HalfCellSize)
	#i1b_at.region = Rect2(HalfCellSize,0,HalfCellSize,HalfCellSize)
	#i1c_at.region = Rect2(0,HalfCellSize,HalfCellSize,HalfCellSize)
	#i1d_at.region = Rect2(HalfCellSize,HalfCellSize,HalfCellSize,HalfCellSize)
	## 2 = 左右
	## 2A 2B
	## 2C 2D
	#i2a_at.region = Rect2(0,0 + CellSize,HalfCellSize,HalfCellSize)
	#i2b_at.region = Rect2(HalfCellSize,0 + CellSize,HalfCellSize,HalfCellSize)
	#i2c_at.region = Rect2(0,HalfCellSize + CellSize,HalfCellSize,HalfCellSize)
	#i2d_at.region = Rect2(HalfCellSize,HalfCellSize + CellSize,HalfCellSize,HalfCellSize)
	## 3 = 上下
	## 3A 3B
	## 3C 3D
	#i3a_at.region = Rect2(0,0 + (CellSize * 2),HalfCellSize,HalfCellSize)
	#i3b_at.region = Rect2(HalfCellSize,0 + (CellSize * 2),HalfCellSize,HalfCellSize)
	#i3c_at.region = Rect2(0,HalfCellSize + (CellSize * 2),HalfCellSize,HalfCellSize)
	#i3d_at.region = Rect2(HalfCellSize,HalfCellSize + (CellSize * 2),HalfCellSize,HalfCellSize)
	## 4 = 4つ角
	## 4A 4B
	## 4C 4D
	#i4a_at.region = Rect2(0,0 + (CellSize * 3),HalfCellSize,HalfCellSize)
	#i4b_at.region = Rect2(HalfCellSize,0 + (CellSize * 3),HalfCellSize,HalfCellSize)
	#i4c_at.region = Rect2(0,HalfCellSize + (CellSize * 3),HalfCellSize,HalfCellSize)
	#i4d_at.region = Rect2(HalfCellSize,HalfCellSize + (CellSize * 3),HalfCellSize,HalfCellSize)
	## 5 = 全面
	## 5A 5B
	## 5C 5D
	#i5a_at.region = Rect2(0,0 + (CellSize * 4),HalfCellSize,HalfCellSize)
	#i5b_at.region = Rect2(HalfCellSize,0 + (CellSize * 4),HalfCellSize,HalfCellSize)
	#i5c_at.region = Rect2(0,HalfCellSize + (CellSize * 4),HalfCellSize,HalfCellSize)
	#i5d_at.region = Rect2(HalfCellSize,HalfCellSize + (CellSize * 4),HalfCellSize,HalfCellSize)
	#
	#var i1a:Image = i1a_at.get_image()
	#var i1b:Image = i1b_at.get_image()
	#var i1c:Image = i1c_at.get_image()
	#var i1d:Image = i1d_at.get_image()
	#var i2a:Image = i2a_at.get_image()
	#var i2b:Image = i2b_at.get_image()
	#var i2c:Image = i2c_at.get_image()
	#var i2d:Image = i2d_at.get_image()
	#var i3a:Image = i3a_at.get_image()
	#var i3b:Image = i3b_at.get_image()
	#var i3c:Image = i3c_at.get_image()
	#var i3d:Image = i3d_at.get_image()
	#var i4a:Image = i4a_at.get_image()
	#var i4b:Image = i4b_at.get_image()
	#var i4c:Image = i4c_at.get_image()
	#var i4d:Image = i4d_at.get_image()
	#var i5a:Image = i5a_at.get_image()
	#var i5b:Image = i5b_at.get_image()
	#var i5c:Image = i5c_at.get_image()
	#var i5d:Image = i5d_at.get_image()
	## ↓↓↓↓↓
	#
	## 5A 5B   4A 5B   5A 4b   4a 4b   5A 5B   4A 5B
	## 5C 5D   5C 5D   5c 5d   5c 5d   5c 4d   5c 4d
	#var row1_1:Image = concat_image_right(i5a,i5b)
	#row1_1 = concat_image_right(row1_1,i4a)
	#row1_1 = concat_image_right(row1_1,i5b)
#
	#row1_1 = concat_image_right(row1_1,i5a)
	#row1_1 = concat_image_right(row1_1,i4b)
#
	#row1_1 = concat_image_right(row1_1,i4a)
	#row1_1 = concat_image_right(row1_1,i4b)
#
	#row1_1 = concat_image_right(row1_1,i5a)
	#row1_1 = concat_image_right(row1_1,i5b)
#
	#row1_1 = concat_image_right(row1_1,i4a)
	#row1_1 = concat_image_right(row1_1,i5b)
	#var row1_2:Image = concat_image_right(i5c,i5d)
	#row1_2 = concat_image_right(row1_2,i5c)
	#row1_2 = concat_image_right(row1_2,i5d)
#
	#row1_2 = concat_image_right(row1_2,i5c)
	#row1_2 = concat_image_right(row1_2,i5d)
#
	#row1_2 = concat_image_right(row1_2,i5c)
	#row1_2 = concat_image_right(row1_2,i5d)
#
	#row1_2 = concat_image_right(row1_2,i5c)
	#row1_2 = concat_image_right(row1_2,i4d)
#
	#row1_2 = concat_image_right(row1_2,i5c)
	#row1_2 = concat_image_right(row1_2,i4d)
#
	## -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	## 5A 4B   4A 4B   5A 5B   4A 5B   5A 4B   4A 4B
	## 5c 4d   5c 4d   4c 5d   4c 5d   4c 5d   4c 5d
	#var row2_1:Image = concat_image_right(i5a,i4b)
	#row2_1 = concat_image_right(row2_1,i4a)
	#row2_1 = concat_image_right(row2_1,i4b)
#
	#row2_1 = concat_image_right(row2_1,i5a)
	#row2_1 = concat_image_right(row2_1,i5b)
#
	#row2_1 = concat_image_right(row2_1,i4a)
	#row2_1 = concat_image_right(row2_1,i5b)
#
	#row2_1 = concat_image_right(row2_1,i5a)
	#row2_1 = concat_image_right(row2_1,i4b)
#
	#row2_1 = concat_image_right(row2_1,i4a)
	#row2_1 = concat_image_right(row2_1,i4b)
	#var row2_2:Image = concat_image_right(i5c,i4d)
	#row2_2 = concat_image_right(row2_2,i5c)
	#row2_2 = concat_image_right(row2_2,i4d)
#
	#row2_2 = concat_image_right(row2_2,i4c)
	#row2_2 = concat_image_right(row2_2,i5d)
#
	#row2_2 = concat_image_right(row2_2,i4c)
	#row2_2 = concat_image_right(row2_2,i5d)
#
	#row2_2 = concat_image_right(row2_2,i4c)
	#row2_2 = concat_image_right(row2_2,i5d)
#
	#row2_2 = concat_image_right(row2_2,i4c)
	#row2_2 = concat_image_right(row2_2,i5d)
	#
	## -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	## 5a 5b   4a 5b   5a 4b   4a 4b   2a 5b   2a 4b
	## 4c 4d   4c 4d   4c 4d   4c 4d   2c 5d   2c 5d
	#var row3_1:Image = concat_image_right(i5a,i5b)
	#row3_1 = concat_image_right(row3_1,i4a)
	#row3_1 = concat_image_right(row3_1,i5b)
#
	#row3_1 = concat_image_right(row3_1,i5a)
	#row3_1 = concat_image_right(row3_1,i4b)
#
	#row3_1 = concat_image_right(row3_1,i4a)
	#row3_1 = concat_image_right(row3_1,i4b)
#
	#row3_1 = concat_image_right(row3_1,i2a)
	#row3_1 = concat_image_right(row3_1,i5b)
#
	#row3_1 = concat_image_right(row3_1,i2a)
	#row3_1 = concat_image_right(row3_1,i4b)
	#var row3_2:Image = concat_image_right(i4c,i4d)
	#row3_2 = concat_image_right(row3_2,i4c)
	#row3_2 = concat_image_right(row3_2,i4d)
#
	#row3_2 = concat_image_right(row3_2,i4c)
	#row3_2 = concat_image_right(row3_2,i4d)
#
	#row3_2 = concat_image_right(row3_2,i4c)
	#row3_2 = concat_image_right(row3_2,i4d)
#
	#row3_2 = concat_image_right(row3_2,i2c)
	#row3_2 = concat_image_right(row3_2,i5d)
#
	#row3_2 = concat_image_right(row3_2,i2c)
	#row3_2 = concat_image_right(row3_2,i5d)
	## -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	## 2a 5b   2a 4b   3a 3b   3a 3b   3a 3b   3a 3b
	## 2c 4d   2c 4d   5c 4d   5c 5d   4c 5d   4c 4d
	#var row4_1:Image = concat_image_right(i2a,i5b)
	#row4_1 = concat_image_right(row4_1,i2a)
	#row4_1 = concat_image_right(row4_1,i4b)
#
	#row4_1 = concat_image_right(row4_1,i3a)
	#row4_1 = concat_image_right(row4_1,i3b)
#
	#row4_1 = concat_image_right(row4_1,i3a)
	#row4_1 = concat_image_right(row4_1,i3b)
#
	#row4_1 = concat_image_right(row4_1,i3a)
	#row4_1 = concat_image_right(row4_1,i3b)
#
	#row4_1 = concat_image_right(row4_1,i3a)
	#row4_1 = concat_image_right(row4_1,i3b)
	#var row4_2:Image = concat_image_right(i2c,i4d)
	#row4_2 = concat_image_right(row4_2,i2c)
	#row4_2 = concat_image_right(row4_2,i4d)
#
	#row4_2 = concat_image_right(row4_2,i5c)
	#row4_2 = concat_image_right(row4_2,i5d)
#
	#row4_2 = concat_image_right(row4_2,i5c)
	#row4_2 = concat_image_right(row4_2,i4d)
#
	#row4_2 = concat_image_right(row4_2,i4c)
	#row4_2 = concat_image_right(row4_2,i5d)
#
	#row4_2 = concat_image_right(row4_2,i4c)
	#row4_2 = concat_image_right(row4_2,i4d)
	## -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	## 5a 2b   5a 2b   4a 2b   4a 2b   5a 5b   4a 5b
	## 5c 2d   4c 2d   5c 2d   4c 2d   3c 3d   3c 3d
	#var row5_1:Image = concat_image_right(i5a,i2b)
	#row5_1 = concat_image_right(row5_1,i5a)
	#row5_1 = concat_image_right(row5_1,i2b)
#
	#row5_1 = concat_image_right(row5_1,i4a)
	#row5_1 = concat_image_right(row5_1,i2b)
#
	#row5_1 = concat_image_right(row5_1,i4a)
	#row5_1 = concat_image_right(row5_1,i2b)
#
	#row5_1 = concat_image_right(row5_1,i5a)
	#row5_1 = concat_image_right(row5_1,i5b)
#
	#row5_1 = concat_image_right(row5_1,i4a)
	#row5_1 = concat_image_right(row5_1,i5b)
	#var row5_2:Image = concat_image_right(i5c,i2d)
	#row5_2 = concat_image_right(row5_2,i4c)
	#row5_2 = concat_image_right(row5_2,i2d)
#
	#row5_2 = concat_image_right(row5_2,i5c)
	#row5_2 = concat_image_right(row5_2,i2d)
#
	#row5_2 = concat_image_right(row5_2,i4c)
	#row5_2 = concat_image_right(row5_2,i2d)
#
	#row5_2 = concat_image_right(row5_2,i3c)
	#row5_2 = concat_image_right(row5_2,i3d)
#
	#row5_2 = concat_image_right(row5_2,i3c)
	#row5_2 = concat_image_right(row5_2,i3d)
	## -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	## 5a 4b   4a 4b   2a 2b   3a 3b   1a 3b   1a 3b
	## 3c 3d   3c 3d   2c 2d   3c 3d   2c 5d   2c 4d
	#var row6_1:Image = concat_image_right(i5a,i4b)
	#row6_1 = concat_image_right(row6_1,i4a)
	#row6_1 = concat_image_right(row6_1,i4b)
#
	#row6_1 = concat_image_right(row6_1,i2a)
	#row6_1 = concat_image_right(row6_1,i2b)
#
	#row6_1 = concat_image_right(row6_1,i3a)
	#row6_1 = concat_image_right(row6_1,i3b)
#
	#row6_1 = concat_image_right(row6_1,i1a)
	#row6_1 = concat_image_right(row6_1,i3b)
#
	#row6_1 = concat_image_right(row6_1,i1a)
	#row6_1 = concat_image_right(row6_1,i3b)
	#var row6_2:Image = concat_image_right(i3c,i3d)
	#row6_2 = concat_image_right(row6_2,i3c)
	#row6_2 = concat_image_right(row6_2,i3d)
#
	#row6_2 = concat_image_right(row6_2,i2c)
	#row6_2 = concat_image_right(row6_2,i2d)
#
	#row6_2 = concat_image_right(row6_2,i3c)
	#row6_2 = concat_image_right(row6_2,i3d)
#
	#row6_2 = concat_image_right(row6_2,i2c)
	#row6_2 = concat_image_right(row6_2,i5d)
#
	#row6_2 = concat_image_right(row6_2,i2c)
	#row6_2 = concat_image_right(row6_2,i4d)
	## -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	## 3a 1b   3a 1b   5a 2b   4a 2b   2b 5b   2b 4b
	## 5c 2d   4c 2d   3c 1d   3c 1d   1c 3d   1c 3d
	#var row7_1:Image = concat_image_right(i3a,i1b)
	#row7_1 = concat_image_right(row7_1,i3a)
	#row7_1 = concat_image_right(row7_1,i1b)
#
	#row7_1 = concat_image_right(row7_1,i5a)
	#row7_1 = concat_image_right(row7_1,i2b)
#
	#row7_1 = concat_image_right(row7_1,i4a)
	#row7_1 = concat_image_right(row7_1,i2b)
#
	#row7_1 = concat_image_right(row7_1,i2a)
	#row7_1 = concat_image_right(row7_1,i5b)
#
	#row7_1 = concat_image_right(row7_1,i2a)
	#row7_1 = concat_image_right(row7_1,i4b)
	#var row7_2:Image = concat_image_right(i5c,i2d)
	#row7_2 = concat_image_right(row7_2,i4c)
	#row7_2 = concat_image_right(row7_2,i2d)
#
	#row7_2 = concat_image_right(row7_2,i3c)
	#row7_2 = concat_image_right(row7_2,i1d)
#
	#row7_2 = concat_image_right(row7_2,i3c)
	#row7_2 = concat_image_right(row7_2,i1d)
#
	#row7_2 = concat_image_right(row7_2,i1c)
	#row7_2 = concat_image_right(row7_2,i3d)
#
	#row7_2 = concat_image_right(row7_2,i1c)
	#row7_2 = concat_image_right(row7_2,i3d)	
	## -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	## 1a 1b   1a 3b   2a 2b   3a 1b   1a 1b   1a 1b
	## 2c 2d   1c 3d   1c 1d   3c 1d   1c 1d   1c 1d
	#var row8_1:Image = concat_image_right(i1a,i1b)
	#row8_1 = concat_image_right(row8_1,i1a)
	#row8_1 = concat_image_right(row8_1,i3b)
#
	#row8_1 = concat_image_right(row8_1,i2a)
	#row8_1 = concat_image_right(row8_1,i2b)
#
	#row8_1 = concat_image_right(row8_1,i3a)
	#row8_1 = concat_image_right(row8_1,i1b)
#
	#row8_1 = concat_image_right(row8_1,i1a)
	#row8_1 = concat_image_right(row8_1,i1b)
#
	#row8_1 = concat_image_right(row8_1,i1a)
	#row8_1 = concat_image_right(row8_1,i1b)
	#var row8_2:Image = concat_image_right(i2c,i2d)
	#row8_2 = concat_image_right(row8_2,i1c)
	#row8_2 = concat_image_right(row8_2,i3d)
#
	#row8_2 = concat_image_right(row8_2,i1c)
	#row8_2 = concat_image_right(row8_2,i1d)
#
	#row8_2 = concat_image_right(row8_2,i3c)
	#row8_2 = concat_image_right(row8_2,i1d)
#
	#row8_2 = concat_image_right(row8_2,i1c)
	#row8_2 = concat_image_right(row8_2,i1d)
#
	#row8_2 = concat_image_right(row8_2,i1c)
	#row8_2 = concat_image_right(row8_2,i1d)
	## -- -- * -- -- * -- -- * -- -- * -- -- * -- --
#
	#var final:Image = concat_image_bottom(row1_1,row1_2)
	#final = concat_image_bottom(final,row2_1)
	#final = concat_image_bottom(final,row2_2)
	#final = concat_image_bottom(final,row3_1)
	#final = concat_image_bottom(final,row3_2)
	#final = concat_image_bottom(final,row4_1)
	#final = concat_image_bottom(final,row4_2)
	#final = concat_image_bottom(final,row5_1)
	#final = concat_image_bottom(final,row5_2)
	#final = concat_image_bottom(final,row6_1)
	#final = concat_image_bottom(final,row6_2)
	#final = concat_image_bottom(final,row7_1)
	#final = concat_image_bottom(final,row7_2)
	#final = concat_image_bottom(final,row8_1)
	#final = concat_image_bottom(final,row8_2)
	#
	#return final

func conv_maker(img:Image, tilesize:int) -> Image:
	var CellSize:int = tilesize
	var HalfCellSize:int = tilesize / 2
	#if tex == null:return null
		# ウディタタイプ
	#var i1a_at = AtlasTexture.new()
	#var i1b_at = AtlasTexture.new()
	#var i1c_at = AtlasTexture.new()
	#var i1d_at = AtlasTexture.new()
	#var i2a_at = AtlasTexture.new()
	#var i2b_at = AtlasTexture.new()
	#var i2c_at = AtlasTexture.new()
	#var i2d_at = AtlasTexture.new()
	#var i3a_at = AtlasTexture.new()
	#var i3b_at = AtlasTexture.new()
	#var i3c_at = AtlasTexture.new()
	#var i3d_at = AtlasTexture.new()
	#var i4a_at = AtlasTexture.new()
	#var i4b_at = AtlasTexture.new()
	#var i4c_at = AtlasTexture.new()
	#var i4d_at = AtlasTexture.new()
	#var i5a_at = AtlasTexture.new()
	#var i5b_at = AtlasTexture.new()
	#var i5c_at = AtlasTexture.new()
	#var i5d_at = AtlasTexture.new()
	#var i6a_at = AtlasTexture.new()
	#var i6b_at = AtlasTexture.new()
	#var i6c_at = AtlasTexture.new()
	#var i6d_at = AtlasTexture.new()
	#i1a_at.atlas = tex
	#i1b_at.atlas = tex
	#i1c_at.atlas = tex
	#i1d_at.atlas = tex
	#i2a_at.atlas = tex
	#i2b_at.atlas = tex
	#i2c_at.atlas = tex
	#i2d_at.atlas = tex
	#i3a_at.atlas = tex
	#i3b_at.atlas = tex
	#i3c_at.atlas = tex
	#i3d_at.atlas = tex
	#i4a_at.atlas = tex
	#i4b_at.atlas = tex
	#i4c_at.atlas = tex
	#i4d_at.atlas = tex
	#i5a_at.atlas = tex
	#i5b_at.atlas = tex
	#i5c_at.atlas = tex
	#i5d_at.atlas = tex
	#i6a_at.atlas = tex
	#i6b_at.atlas = tex
	#i6c_at.atlas = tex
	#i6d_at.atlas = tex
	# 1 = 島
	# 1A 1B
	# 1C 1D
	var i1a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1a.blit_rect(img,Rect2i(0,HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1b.blit_rect(img,Rect2i(HalfCellSize*3,HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1c.blit_rect(img,Rect2i(0,HalfCellSize*5,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1d.blit_rect(img,Rect2i(HalfCellSize*3,HalfCellSize*5,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	
	# i1a_at.region = Rect2(0,HalfCellSize*2,HalfCellSize,HalfCellSize)#0,2
	# i1b_at.region = Rect2(HalfCellSize*3,HalfCellSize*2,HalfCellSize,HalfCellSize)#3,2
	# i1c_at.region = Rect2(0,HalfCellSize*5,HalfCellSize,HalfCellSize)#0,5
	# i1d_at.region = Rect2(HalfCellSize*3,HalfCellSize*5,HalfCellSize,HalfCellSize)#3,5
	# 2 = 左右
	# 2A 2B
	# 2C 2D
	var i2a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2a.blit_rect(img,Rect2i(0,HalfCellSize*4,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2b.blit_rect(img,Rect2i(HalfCellSize*3,HalfCellSize*4,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2c.blit_rect(img,Rect2i(0,HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2d.blit_rect(img,Rect2i(HalfCellSize*3,HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# i2a_at.region = Rect2(0,HalfCellSize*4,HalfCellSize,HalfCellSize)#0,4
	# i2b_at.region = Rect2(HalfCellSize*3,HalfCellSize*4,HalfCellSize,HalfCellSize)#3,3
	# i2c_at.region = Rect2(0,HalfCellSize*3,HalfCellSize,HalfCellSize)#0,3
	# i2d_at.region = Rect2(HalfCellSize*3,HalfCellSize*3,HalfCellSize,HalfCellSize)#3,4
	# 3 = 上下
	# 3A 3B
	# 3C 3D
	var i3a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3a.blit_rect(img,Rect2i(HalfCellSize*2,HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3b.blit_rect(img,Rect2i(HalfCellSize,HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3c.blit_rect(img,Rect2i(HalfCellSize*2,HalfCellSize*5,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3d.blit_rect(img,Rect2i(HalfCellSize,HalfCellSize*5,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# i3a_at.region = Rect2(HalfCellSize*2,HalfCellSize*2,HalfCellSize,HalfCellSize)#2,2
	# i3b_at.region = Rect2(HalfCellSize,HalfCellSize*2,HalfCellSize,HalfCellSize)#1,2
	# i3c_at.region = Rect2(HalfCellSize*2,HalfCellSize*5,HalfCellSize,HalfCellSize)#2,5
	# i3d_at.region = Rect2(HalfCellSize,HalfCellSize*5,HalfCellSize,HalfCellSize)#1,5
	# 4 = 4つ角
	# 4A 4B
	# 4C 4D
	var i4a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4a.blit_rect(img,Rect2i(HalfCellSize*2,0,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4b.blit_rect(img,Rect2i(HalfCellSize*3,0,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4c.blit_rect(img,Rect2i(HalfCellSize*2,HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4d.blit_rect(img,Rect2i(HalfCellSize*3,HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# i4a_at.region = Rect2(HalfCellSize*2,0,HalfCellSize,HalfCellSize)#2,0x
	# i4b_at.region = Rect2(HalfCellSize*3,0,HalfCellSize,HalfCellSize)#3,0
	# i4c_at.region = Rect2(HalfCellSize*2,HalfCellSize,HalfCellSize,HalfCellSize)#2,1
	# i4d_at.region = Rect2(HalfCellSize*3,HalfCellSize,HalfCellSize,HalfCellSize)#3,1
	# 5 = 全面
	# 5A 5B
	# 5C 5D
	var i5a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i5a.blit_rect(img,Rect2i(HalfCellSize,HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i5b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i5b.blit_rect(img,Rect2i(HalfCellSize*2,HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i5c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i5c.blit_rect(img,Rect2i(HalfCellSize,HalfCellSize*4,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i5d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i5d.blit_rect(img,Rect2i(HalfCellSize*2,HalfCellSize*4,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# i5a_at.region = Rect2(HalfCellSize,HalfCellSize*3,HalfCellSize,HalfCellSize)#1,3
	# i5b_at.region = Rect2(HalfCellSize*2,HalfCellSize*3,HalfCellSize,HalfCellSize)#2,3
	# i5c_at.region = Rect2(HalfCellSize,HalfCellSize*4,HalfCellSize,HalfCellSize)#1,4
	# i5d_at.region = Rect2(HalfCellSize*2,HalfCellSize*4,HalfCellSize,HalfCellSize)#2,4

	# 6 = サムネ用
	var i6a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i6a.blit_rect(img,Rect2i(0,0,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i6b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i6b.blit_rect(img,Rect2i(HalfCellSize, 0,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i6c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i6c.blit_rect(img,Rect2i(0, HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i6d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i6d.blit_rect(img,Rect2i(HalfCellSize,HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# i6a_at.region = Rect2(0,0,HalfCellSize,HalfCellSize)#0,0
	# i6b_at.region = Rect2(0,HalfCellSize,HalfCellSize,HalfCellSize)#0,1
	# i6c_at.region = Rect2(HalfCellSize,0,HalfCellSize,HalfCellSize)#1,0
	# i6d_at.region = Rect2(HalfCellSize,HalfCellSize,HalfCellSize,HalfCellSize)#1,1
	
	# var i1b:Image = i1b_at.get_image()
	# var i1c:Image = i1c_at.get_image()
	# var i1d:Image = i1d_at.get_image()
	# var i2a:Image = i2a_at.get_image()
	# var i2b:Image = i2b_at.get_image()
	# var i2c:Image = i2c_at.get_image()
	# var i2d:Image = i2d_at.get_image()
	# var i3a:Image = i3a_at.get_image()
	# var i3b:Image = i3b_at.get_image()
	# var i3c:Image = i3c_at.get_image()
	# var i3d:Image = i3d_at.get_image()
	# var i4a:Image = i4a_at.get_image()
	# var i4b:Image = i4b_at.get_image()
	# var i4c:Image = i4c_at.get_image()
	# var i4d:Image = i4d_at.get_image()
	# var i5a:Image = i5a_at.get_image()
	# var i5b:Image = i5b_at.get_image()
	# var i5c:Image = i5c_at.get_image()
	# var i5d:Image = i5d_at.get_image()
	# var i6a:Image = i5a_at.get_image()
	# var i6b:Image = i5b_at.get_image()
	# var i6c:Image = i5c_at.get_image()
	# var i6d:Image = i5d_at.get_image()
	# ↓↓↓↓↓
	
	# 5D 5C   4A 5C   5D 4b   4a 4b   5D 5C   4A 5C
	# 5B 5A   5B 5A   5B 5A   5B 5A   5B 4d   5B 4d
	var row1_1:Image = concat_image_right(i5d,i5c)
	row1_1 = concat_image_right(row1_1,i4a)
	row1_1 = concat_image_right(row1_1,i5c)

	row1_1 = concat_image_right(row1_1,i5d)
	row1_1 = concat_image_right(row1_1,i4b)

	row1_1 = concat_image_right(row1_1,i4a)
	row1_1 = concat_image_right(row1_1,i4b)

	row1_1 = concat_image_right(row1_1,i5d)
	row1_1 = concat_image_right(row1_1,i5c)

	row1_1 = concat_image_right(row1_1,i4a)
	row1_1 = concat_image_right(row1_1,i5c)
	var row1_2:Image = concat_image_right(i5b,i5a)
	row1_2 = concat_image_right(row1_2,i5b)
	row1_2 = concat_image_right(row1_2,i5a)

	row1_2 = concat_image_right(row1_2,i5b)
	row1_2 = concat_image_right(row1_2,i5a)

	row1_2 = concat_image_right(row1_2,i5b)
	row1_2 = concat_image_right(row1_2,i5a)

	row1_2 = concat_image_right(row1_2,i5b)
	row1_2 = concat_image_right(row1_2,i4d)

	row1_2 = concat_image_right(row1_2,i5b)
	row1_2 = concat_image_right(row1_2,i4d)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 5D 4B   4A 4B   5D 5C   4A 5C   5D 4B   4A 4B
	# 5B 4d   5B 4d   4c 5A   4c 5A   4c 5A   4c 5A
	var row2_1:Image = concat_image_right(i5d,i4b)
	row2_1 = concat_image_right(row2_1,i4a)
	row2_1 = concat_image_right(row2_1,i4b)

	row2_1 = concat_image_right(row2_1,i5d)
	row2_1 = concat_image_right(row2_1,i5c)

	row2_1 = concat_image_right(row2_1,i4a)
	row2_1 = concat_image_right(row2_1,i5c)

	row2_1 = concat_image_right(row2_1,i5d)
	row2_1 = concat_image_right(row2_1,i4b)

	row2_1 = concat_image_right(row2_1,i4a)
	row2_1 = concat_image_right(row2_1,i4b)
	var row2_2:Image = concat_image_right(i5b,i4d)
	row2_2 = concat_image_right(row2_2,i5b)
	row2_2 = concat_image_right(row2_2,i4d)

	row2_2 = concat_image_right(row2_2,i4c)
	row2_2 = concat_image_right(row2_2,i5a)

	row2_2 = concat_image_right(row2_2,i4c)
	row2_2 = concat_image_right(row2_2,i5a)

	row2_2 = concat_image_right(row2_2,i4c)
	row2_2 = concat_image_right(row2_2,i5a)

	row2_2 = concat_image_right(row2_2,i4c)
	row2_2 = concat_image_right(row2_2,i5a)
	
	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 5D 5C   4a 5C   5D 4b   4a 4b   2a 5C   2a 4b
	# 4c 4d   4c 4d   4c 4d   4c 4d   2c 5A   2c 5A
	var row3_1:Image = concat_image_right(i5d,i5c)
	row3_1 = concat_image_right(row3_1,i4a)
	row3_1 = concat_image_right(row3_1,i5c)

	row3_1 = concat_image_right(row3_1,i5d)
	row3_1 = concat_image_right(row3_1,i4b)

	row3_1 = concat_image_right(row3_1,i4a)
	row3_1 = concat_image_right(row3_1,i4b)

	row3_1 = concat_image_right(row3_1,i2a)
	row3_1 = concat_image_right(row3_1,i5c)

	row3_1 = concat_image_right(row3_1,i2a)
	row3_1 = concat_image_right(row3_1,i4b)
	var row3_2:Image = concat_image_right(i4c,i4d)
	row3_2 = concat_image_right(row3_2,i4c)
	row3_2 = concat_image_right(row3_2,i4d)

	row3_2 = concat_image_right(row3_2,i4c)
	row3_2 = concat_image_right(row3_2,i4d)

	row3_2 = concat_image_right(row3_2,i4c)
	row3_2 = concat_image_right(row3_2,i4d)

	row3_2 = concat_image_right(row3_2,i2c)
	row3_2 = concat_image_right(row3_2,i5a)

	row3_2 = concat_image_right(row3_2,i2c)
	row3_2 = concat_image_right(row3_2,i5a)
	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 2a 5C   2a 4b   3a 3b   3a 3b   3a 3b   3a 3b
	# 2c 4d   2c 4d   5B 5A   5B 4d   4c 5A   4c 4d
	var row4_1:Image = concat_image_right(i2a,i5c)
	row4_1 = concat_image_right(row4_1,i2a)
	row4_1 = concat_image_right(row4_1,i4b)

	row4_1 = concat_image_right(row4_1,i3a)
	row4_1 = concat_image_right(row4_1,i3b)

	row4_1 = concat_image_right(row4_1,i3a)
	row4_1 = concat_image_right(row4_1,i3b)

	row4_1 = concat_image_right(row4_1,i3a)
	row4_1 = concat_image_right(row4_1,i3b)

	row4_1 = concat_image_right(row4_1,i3a)
	row4_1 = concat_image_right(row4_1,i3b)
	var row4_2:Image = concat_image_right(i2c,i4d)
	row4_2 = concat_image_right(row4_2,i2c)
	row4_2 = concat_image_right(row4_2,i4d)

	row4_2 = concat_image_right(row4_2,i5b)
	row4_2 = concat_image_right(row4_2,i5a)

	row4_2 = concat_image_right(row4_2,i5b)
	row4_2 = concat_image_right(row4_2,i4d)

	row4_2 = concat_image_right(row4_2,i4c)
	row4_2 = concat_image_right(row4_2,i5a)

	row4_2 = concat_image_right(row4_2,i4c)
	row4_2 = concat_image_right(row4_2,i4d)
	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 5D 2b   5D 2b   4a 2b   4a 2b   5D 5C   4a 5C
	# 5B 2d   4c 2d   5B 2d   4c 2d   3c 3d   3c 3d
	var row5_1:Image = concat_image_right(i5d,i2b)
	row5_1 = concat_image_right(row5_1,i5d)
	row5_1 = concat_image_right(row5_1,i2b)

	row5_1 = concat_image_right(row5_1,i4a)
	row5_1 = concat_image_right(row5_1,i2b)

	row5_1 = concat_image_right(row5_1,i4a)
	row5_1 = concat_image_right(row5_1,i2b)

	row5_1 = concat_image_right(row5_1,i5d)
	row5_1 = concat_image_right(row5_1,i5c)

	row5_1 = concat_image_right(row5_1,i4a)
	row5_1 = concat_image_right(row5_1,i5c)
	var row5_2:Image = concat_image_right(i5b,i2d)
	row5_2 = concat_image_right(row5_2,i4c)
	row5_2 = concat_image_right(row5_2,i2d)

	row5_2 = concat_image_right(row5_2,i5b)
	row5_2 = concat_image_right(row5_2,i2d)

	row5_2 = concat_image_right(row5_2,i4c)
	row5_2 = concat_image_right(row5_2,i2d)

	row5_2 = concat_image_right(row5_2,i3c)
	row5_2 = concat_image_right(row5_2,i3d)

	row5_2 = concat_image_right(row5_2,i3c)
	row5_2 = concat_image_right(row5_2,i3d)
	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 5D 4b   4a 4b   2a 2b   3a 3b   1a 3b   1a 3b
	# 3c 3d   3c 3d   2c 2d   3c 3d   2c 5A   2c 4d
	var row6_1:Image = concat_image_right(i5d,i4b)
	row6_1 = concat_image_right(row6_1,i4a)
	row6_1 = concat_image_right(row6_1,i4b)

	row6_1 = concat_image_right(row6_1,i2a)
	row6_1 = concat_image_right(row6_1,i2b)

	row6_1 = concat_image_right(row6_1,i3a)
	row6_1 = concat_image_right(row6_1,i3b)

	row6_1 = concat_image_right(row6_1,i1a)
	row6_1 = concat_image_right(row6_1,i3b)

	row6_1 = concat_image_right(row6_1,i1a)
	row6_1 = concat_image_right(row6_1,i3b)
	var row6_2:Image = concat_image_right(i3c,i3d)
	row6_2 = concat_image_right(row6_2,i3c)
	row6_2 = concat_image_right(row6_2,i3d)

	row6_2 = concat_image_right(row6_2,i2c)
	row6_2 = concat_image_right(row6_2,i2d)

	row6_2 = concat_image_right(row6_2,i3c)
	row6_2 = concat_image_right(row6_2,i3d)

	row6_2 = concat_image_right(row6_2,i2c)
	row6_2 = concat_image_right(row6_2,i5a)

	row6_2 = concat_image_right(row6_2,i2c)
	row6_2 = concat_image_right(row6_2,i4d)
	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 3a 1b   3a 1b   5D 2b   4a 2b   2b 5C   2b 4b
	# 5B 2d   4c 2d   3c 1d   3c 1d   1c 3d   1c 3d
	var row7_1:Image = concat_image_right(i3a,i1b)
	row7_1 = concat_image_right(row7_1,i3a)
	row7_1 = concat_image_right(row7_1,i1b)

	row7_1 = concat_image_right(row7_1,i5d)
	row7_1 = concat_image_right(row7_1,i2b)

	row7_1 = concat_image_right(row7_1,i4a)
	row7_1 = concat_image_right(row7_1,i2b)

	row7_1 = concat_image_right(row7_1,i2a)
	row7_1 = concat_image_right(row7_1,i5c)

	row7_1 = concat_image_right(row7_1,i2a)
	row7_1 = concat_image_right(row7_1,i4b)
	var row7_2:Image = concat_image_right(i5b,i2d)
	row7_2 = concat_image_right(row7_2,i4c)
	row7_2 = concat_image_right(row7_2,i2d)

	row7_2 = concat_image_right(row7_2,i3c)
	row7_2 = concat_image_right(row7_2,i1d)

	row7_2 = concat_image_right(row7_2,i3c)
	row7_2 = concat_image_right(row7_2,i1d)

	row7_2 = concat_image_right(row7_2,i1c)
	row7_2 = concat_image_right(row7_2,i3d)

	row7_2 = concat_image_right(row7_2,i1c)
	row7_2 = concat_image_right(row7_2,i3d)	
	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 1a 1b   1a 3b   2a 2b   3a 1b   1a 1b   6a 6b
	# 2c 2d   1c 3d   1c 1d   3c 1d   1c 1d   6c 6d
	var row8_1:Image = concat_image_right(i1a,i1b)
	row8_1 = concat_image_right(row8_1,i1a)
	row8_1 = concat_image_right(row8_1,i3b)

	row8_1 = concat_image_right(row8_1,i2a)
	row8_1 = concat_image_right(row8_1,i2b)

	row8_1 = concat_image_right(row8_1,i3a)
	row8_1 = concat_image_right(row8_1,i1b)

	row8_1 = concat_image_right(row8_1,i1a)
	row8_1 = concat_image_right(row8_1,i1b)

	row8_1 = concat_image_right(row8_1,i6a)
	row8_1 = concat_image_right(row8_1,i6b)
	var row8_2:Image = concat_image_right(i2c,i2d)
	row8_2 = concat_image_right(row8_2,i1c)
	row8_2 = concat_image_right(row8_2,i3d)

	row8_2 = concat_image_right(row8_2,i1c)
	row8_2 = concat_image_right(row8_2,i1d)

	row8_2 = concat_image_right(row8_2,i3c)
	row8_2 = concat_image_right(row8_2,i1d)

	row8_2 = concat_image_right(row8_2,i1c)
	row8_2 = concat_image_right(row8_2,i1d)

	row8_2 = concat_image_right(row8_2,i6c)
	row8_2 = concat_image_right(row8_2,i6d)
	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --

	var final:Image = concat_image_bottom(row1_1,row1_2)
	final = concat_image_bottom(final,row2_1)
	final = concat_image_bottom(final,row2_2)
	final = concat_image_bottom(final,row3_1)
	final = concat_image_bottom(final,row3_2)
	final = concat_image_bottom(final,row4_1)
	final = concat_image_bottom(final,row4_2)
	final = concat_image_bottom(final,row5_1)
	final = concat_image_bottom(final,row5_2)
	final = concat_image_bottom(final,row6_1)
	final = concat_image_bottom(final,row6_2)
	final = concat_image_bottom(final,row7_1)
	final = concat_image_bottom(final,row7_2)
	final = concat_image_bottom(final,row8_1)
	final = concat_image_bottom(final,row8_2)
	
	return final

func conv_maker_waterfall(img:Image, tilesize:int) -> Image:
	var CellSize:int = tilesize
	var HalfCellSize:int = tilesize / 2
	
	var rows = []
	for i in 3:

		# 1 = 左右
		# 1A 1B
		# 1C 1D
		var i1a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
		i1a.blit_rect(img,Rect2i(0,0 + HalfCellSize * 2 * i,HalfCellSize,HalfCellSize),Vector2i.ZERO)
		var i1b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
		i1b.blit_rect(img,Rect2i(HalfCellSize* 3,0 + HalfCellSize * 2 * i,HalfCellSize,HalfCellSize),Vector2i.ZERO)
		var i1c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
		i1c.blit_rect(img,Rect2i(0, HalfCellSize + HalfCellSize * 2 * i,HalfCellSize,HalfCellSize),Vector2i.ZERO)
		var i1d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
		i1d.blit_rect(img,Rect2i(HalfCellSize * 3,HalfCellSize + HalfCellSize * 2 * i,HalfCellSize,HalfCellSize),Vector2i.ZERO)

		# 3 = 全面
		# 3A 3B
		# 3C 3D
		var i3a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
		i3a.blit_rect(img,Rect2i(HalfCellSize,0 + HalfCellSize * 2 * i,HalfCellSize,HalfCellSize),Vector2i.ZERO)
		var i3b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
		i3b.blit_rect(img,Rect2i(HalfCellSize * 2,0 + HalfCellSize * 2 * i,HalfCellSize,HalfCellSize),Vector2i.ZERO)
		var i3c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
		i3c.blit_rect(img,Rect2i(HalfCellSize,HalfCellSize + HalfCellSize * 2 * i,HalfCellSize,HalfCellSize),Vector2i.ZERO)
		var i3d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
		i3d.blit_rect(img,Rect2i(HalfCellSize * 2,HalfCellSize + HalfCellSize * 2 * i,HalfCellSize,HalfCellSize),Vector2i.ZERO)

		# ↓↓↓↓↓
		
		# 1A 3A 3B 3A 3B 1B 1A 1B
		# 1C 3C 3D 3C 3D 1D 1C 1D
		
		var row1_1:Image = concat_image_right(i1a, i3a)
		row1_1 = concat_image_right(row1_1, i3b)
		row1_1 = concat_image_right(row1_1, i3a)

		row1_1 = concat_image_right(row1_1, i3b)
		row1_1 = concat_image_right(row1_1, i1b)

		row1_1 = concat_image_right(row1_1, i1a)
		row1_1 = concat_image_right(row1_1, i1b)

		var row1_2:Image = concat_image_right(i1c, i3c)
		row1_2 = concat_image_right(row1_2, i3d)
		row1_2 = concat_image_right(row1_2, i3c)
	
		row1_2 = concat_image_right(row1_2, i3d)
		row1_2 = concat_image_right(row1_2, i1d)
	
		row1_2 = concat_image_right(row1_2, i1c)
		row1_2 = concat_image_right(row1_2, i1d)
		
		rows.append(concat_image_bottom(row1_1, row1_2))
	
	var final:Image = concat_image_bottom(rows[0],rows[1])
	final = concat_image_bottom(final,rows[2])
	
	return final

func conv_maker_a3(img:Image, tilesize:int) -> Image:
	var CellSize:int = tilesize
	var HalfCellSize:int = tilesize / 2
	
	## A4の床部分の高さ
	var base_y = 0

	# 1 = 角
	# 1A 1B
	# 1C 1D
	var i1a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1a.blit_rect(img,Rect2i(0, base_y ,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1b.blit_rect(img,Rect2i(HalfCellSize*3, base_y,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1c.blit_rect(img,Rect2i(0,base_y + HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1d.blit_rect(img,Rect2i(HalfCellSize*3,base_y +  HalfCellSize * 3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# 2 = 左右
	# 2A 2B
	# 2C 2D
	var i2a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2a.blit_rect(img,Rect2i(0,base_y + HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2b.blit_rect(img,Rect2i(HalfCellSize*3,base_y + HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2c.blit_rect(img,Rect2i(0,base_y + HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2d.blit_rect(img,Rect2i(HalfCellSize*3,base_y + HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# 3 = 上下
	# 3A 3B
	# 3C 3D
	var i3a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3a.blit_rect(img,Rect2i(HalfCellSize,base_y,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3b.blit_rect(img,Rect2i(HalfCellSize * 2,base_y,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3c.blit_rect(img,Rect2i(HalfCellSize,base_y + HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3d.blit_rect(img,Rect2i(HalfCellSize * 2,base_y +HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)

	# 4 = 全面
	# 4A 4B
	# 4C 4D
	var i4a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4a.blit_rect(img,Rect2i(HalfCellSize,base_y + HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4b.blit_rect(img,Rect2i(HalfCellSize * 2,base_y + HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4c.blit_rect(img,Rect2i(HalfCellSize,base_y + HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4d.blit_rect(img,Rect2i(HalfCellSize * 2,base_y +HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)

	# ↓↓↓↓↓
	
	#上面
	# 1A 3A   3B 3A   3B 1B   1A 1B
	# 2A 4A   4B 4A   4B 2B   2A 2B
	
	var row1_1:Image = concat_image_right(i1a,i3a)
	row1_1 = concat_image_right(row1_1, i3b)
	row1_1 = concat_image_right(row1_1, i3a)

	row1_1 = concat_image_right(row1_1, i3b)
	row1_1 = concat_image_right(row1_1, i1b)

	row1_1 = concat_image_right(row1_1, i1a)
	row1_1 = concat_image_right(row1_1, i1b)

	var row1_2:Image = concat_image_right( i2a, i4a)
	row1_2 = concat_image_right(row1_2, i4b)
	row1_2 = concat_image_right(row1_2, i4a)

	row1_2 = concat_image_right(row1_2, i4b)
	row1_2 = concat_image_right(row1_2, i2b)

	row1_2 = concat_image_right(row1_2, i2a)
	row1_2 = concat_image_right(row1_2, i2b)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 2C 4C 4D 4C 4D 2D 2C 2D
	# 2A 4A 4B 4A 4B 2B 2A 2B
	var row2_1:Image = concat_image_right( i2c, i4c)
	row2_1 = concat_image_right(row2_1, i4d)
	row2_1 = concat_image_right(row2_1, i4c)

	row2_1 = concat_image_right(row2_1, i4d)
	row2_1 = concat_image_right(row2_1, i2d)

	row2_1 = concat_image_right(row2_1, i2c)
	row2_1 = concat_image_right(row2_1, i2d)

	var row2_2:Image = concat_image_right( i2a, i4a)
	row2_2 = concat_image_right(row2_2, i4b)
	row2_2 = concat_image_right(row2_2, i4a)

	row2_2 = concat_image_right(row2_2, i4b)
	row2_2 = concat_image_right(row2_2, i2b)

	row2_2 = concat_image_right(row2_2, i2a)
	row2_2 = concat_image_right(row2_2, i2b)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 2C 4C 4D 4C 4D 2D 2C 2D
	# 1C 3C 3D 3C 3D 1D 1C 1D
	var row3_1:Image = concat_image_right( i2c, i4c)
	row3_1 = concat_image_right(row3_1, i4d)
	row3_1 = concat_image_right(row3_1, i4c)

	row3_1 = concat_image_right(row3_1, i4d)
	row3_1 = concat_image_right(row3_1, i2d)

	row3_1 = concat_image_right(row3_1, i2c)
	row3_1 = concat_image_right(row3_1, i2d)


	var row3_2:Image = concat_image_right( i1c, i3c)
	row3_2 = concat_image_right(row3_2, i3d)
	row3_2 = concat_image_right(row3_2, i3c)

	row3_2 = concat_image_right(row3_2, i3d)
	row3_2 = concat_image_right(row3_2, i1d)

	row3_2 = concat_image_right(row3_2, i1c)
	row3_2 = concat_image_right(row3_2, i1d)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 1A 3A 3B 3A 3B 1B 1A 1B
	# 1C 3C 3D 3C 3D 1D 1C 1D
	var row4_1:Image = concat_image_right( i1a, i3a)
	row4_1 = concat_image_right(row4_1, i3b)
	row4_1 = concat_image_right(row4_1, i3a)

	row4_1 = concat_image_right(row4_1, i3b)
	row4_1 = concat_image_right(row4_1, i1b)

	row4_1 = concat_image_right(row4_1, i1a)
	row4_1 = concat_image_right(row4_1, i1b)

	var row4_2:Image = concat_image_right( i1c, i3c)
	row4_2 = concat_image_right(row4_2, i3d)
	row4_2 = concat_image_right(row4_2, i3c)

	row4_2 = concat_image_right(row4_2, i3d)
	row4_2 = concat_image_right(row4_2, i1d)

	row4_2 = concat_image_right(row4_2, i1c)
	row4_2 = concat_image_right(row4_2, i1d)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --

	var final:Image = concat_image_bottom(row1_1,row1_2)
	final = concat_image_bottom(final,row2_1)
	final = concat_image_bottom(final,row2_2)
	final = concat_image_bottom(final,row3_1)
	final = concat_image_bottom(final,row3_2)
	final = concat_image_bottom(final,row4_1)
	final = concat_image_bottom(final,row4_2)
	
	return final

func conv_maker_a4(img:Image, tilesize:int) -> Image:
	var CellSize:int = tilesize
	var HalfCellSize:int = tilesize / 2
	
	## A4の床部分の高さ
	var base_y = tilesize * 3

	# 1 = 角
	# 1A 1B
	# 1C 1D
	var i1a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1a.blit_rect(img,Rect2i(0, base_y ,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1b.blit_rect(img,Rect2i(HalfCellSize*3, base_y,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1c.blit_rect(img,Rect2i(0,base_y + HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i1d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i1d.blit_rect(img,Rect2i(HalfCellSize*3,base_y +  HalfCellSize * 3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# 2 = 左右
	# 2A 2B
	# 2C 2D
	var i2a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2a.blit_rect(img,Rect2i(0,base_y + HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2b.blit_rect(img,Rect2i(HalfCellSize*3,base_y + HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2c.blit_rect(img,Rect2i(0,base_y + HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i2d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i2d.blit_rect(img,Rect2i(HalfCellSize*3,base_y + HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	# 3 = 上下
	# 3A 3B
	# 3C 3D
	var i3a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3a.blit_rect(img,Rect2i(HalfCellSize,base_y,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3b.blit_rect(img,Rect2i(HalfCellSize * 2,base_y,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3c.blit_rect(img,Rect2i(HalfCellSize,base_y + HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i3d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i3d.blit_rect(img,Rect2i(HalfCellSize * 2,base_y +HalfCellSize*3,HalfCellSize,HalfCellSize),Vector2i.ZERO)

	# 4 = 全面
	# 4A 4B
	# 4C 4D
	var i4a:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4a.blit_rect(img,Rect2i(HalfCellSize,base_y + HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4b:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4b.blit_rect(img,Rect2i(HalfCellSize * 2,base_y + HalfCellSize,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4c:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4c.blit_rect(img,Rect2i(HalfCellSize,base_y + HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)
	var i4d:Image = Image.create(HalfCellSize,HalfCellSize,false,img.get_format())
	i4d.blit_rect(img,Rect2i(HalfCellSize * 2,base_y +HalfCellSize*2,HalfCellSize,HalfCellSize),Vector2i.ZERO)

	# ↓↓↓↓↓
	
	#上面
	# 1A 3A   3B 3A   3B 1B   1A 1B
	# 2A 4A   4B 4A   4B 2B   2A 2B
	
	var row1_1:Image = concat_image_right(i1a,i3a)
	row1_1 = concat_image_right(row1_1, i3b)
	row1_1 = concat_image_right(row1_1, i3a)

	row1_1 = concat_image_right(row1_1, i3b)
	row1_1 = concat_image_right(row1_1, i1b)

	row1_1 = concat_image_right(row1_1, i1a)
	row1_1 = concat_image_right(row1_1, i1b)

	var row1_2:Image = concat_image_right( i2a, i4a)
	row1_2 = concat_image_right(row1_2, i4b)
	row1_2 = concat_image_right(row1_2, i4a)

	row1_2 = concat_image_right(row1_2, i4b)
	row1_2 = concat_image_right(row1_2, i2b)

	row1_2 = concat_image_right(row1_2, i2a)
	row1_2 = concat_image_right(row1_2, i2b)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 2C 4C 4D 4C 4D 2D 2C 2D
	# 2A 4A 4B 4A 4B 2B 2A 2B
	var row2_1:Image = concat_image_right( i2c, i4c)
	row2_1 = concat_image_right(row2_1, i4d)
	row2_1 = concat_image_right(row2_1, i4c)

	row2_1 = concat_image_right(row2_1, i4d)
	row2_1 = concat_image_right(row2_1, i2d)

	row2_1 = concat_image_right(row2_1, i2c)
	row2_1 = concat_image_right(row2_1, i2d)

	var row2_2:Image = concat_image_right( i2a, i4a)
	row2_2 = concat_image_right(row2_2, i4b)
	row2_2 = concat_image_right(row2_2, i4a)

	row2_2 = concat_image_right(row2_2, i4b)
	row2_2 = concat_image_right(row2_2, i2b)

	row2_2 = concat_image_right(row2_2, i2a)
	row2_2 = concat_image_right(row2_2, i2b)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 2C 4C 4D 4C 4D 2D 2C 2D
	# 1C 3C 3D 3C 3D 1D 1C 1D
	var row3_1:Image = concat_image_right( i2c, i4c)
	row3_1 = concat_image_right(row3_1, i4d)
	row3_1 = concat_image_right(row3_1, i4c)

	row3_1 = concat_image_right(row3_1, i4d)
	row3_1 = concat_image_right(row3_1, i2d)

	row3_1 = concat_image_right(row3_1, i2c)
	row3_1 = concat_image_right(row3_1, i2d)


	var row3_2:Image = concat_image_right( i1c, i3c)
	row3_2 = concat_image_right(row3_2, i3d)
	row3_2 = concat_image_right(row3_2, i3c)

	row3_2 = concat_image_right(row3_2, i3d)
	row3_2 = concat_image_right(row3_2, i1d)

	row3_2 = concat_image_right(row3_2, i1c)
	row3_2 = concat_image_right(row3_2, i1d)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --
	# 1A 3A 3B 3A 3B 1B 1A 1B
	# 1C 3C 3D 3C 3D 1D 1C 1D
	var row4_1:Image = concat_image_right( i1a, i3a)
	row4_1 = concat_image_right(row4_1, i3b)
	row4_1 = concat_image_right(row4_1, i3a)

	row4_1 = concat_image_right(row4_1, i3b)
	row4_1 = concat_image_right(row4_1, i1b)

	row4_1 = concat_image_right(row4_1, i1a)
	row4_1 = concat_image_right(row4_1, i1b)

	var row4_2:Image = concat_image_right( i1c, i3c)
	row4_2 = concat_image_right(row4_2, i3d)
	row4_2 = concat_image_right(row4_2, i3c)

	row4_2 = concat_image_right(row4_2, i3d)
	row4_2 = concat_image_right(row4_2, i1d)

	row4_2 = concat_image_right(row4_2, i1c)
	row4_2 = concat_image_right(row4_2, i1d)

	# -- -- * -- -- * -- -- * -- -- * -- -- * -- --

	var final:Image = concat_image_bottom(row1_1,row1_2)
	final = concat_image_bottom(final,row2_1)
	final = concat_image_bottom(final,row2_2)
	final = concat_image_bottom(final,row3_1)
	final = concat_image_bottom(final,row3_2)
	final = concat_image_bottom(final,row4_1)
	final = concat_image_bottom(final,row4_2)
	
	return final

func concat_image_right(base: Image, ext: Image):
	if base.get_width() == 0: return ext
	var output: Image = Image.create(base.get_width() + ext.get_width(),base.get_height(),false,base.get_format())
	output.blit_rect(base,Rect2(0,0,base.get_width(),base.get_height()),Vector2(0,0))
	output.blit_rect(ext,Rect2(0,0,ext.get_width(),ext.get_height()),Vector2(base.get_width(),0))
	return output

func concat_image_bottom(base: Image, ext: Image):
	if base.get_width() == 0: return ext
	var output: Image = Image.create(base.get_width(),base.get_height() + ext.get_height(),false,base.get_format())
	output.blit_rect(base,Rect2(0,0,base.get_width(),base.get_height()),Vector2(0,0))
	output.blit_rect(ext,Rect2(0,0,ext.get_width(),ext.get_height()),Vector2(0,base.get_height()))
	
	#var output: Image = Image.create_from_data(
		#base.get_width(),
		#base.get_height() + ext.get_height(),
		#false,
		#base.get_format(),
		#base.get_data() + ext.get_data()
	#)
	return output

# オートタイルサイズで画像を分割する
# 2次元配列
func cut_Spritesheet(image:Image,cut_size:Vector2) -> Array:
	
	if image.get_width() % int(cut_size.x) != 0 or image.get_height() % int(cut_size.y) != 0:
		printerr("わりきれないが？？？")
		return []
	
	var col_count = image.get_width() / cut_size.x
	var row_count = image.get_height() / cut_size.y
	
	var res_array = []
	for y in range(0,row_count):
		var row = []
		for x in range(0,col_count):
			var new_img:Image = Image.new()
			new_img.create(cut_size.x,cut_size.y,false,image.get_format())
			new_img.blit_rect(image,Rect2(x * cut_size.x, y * cut_size.y,cut_size.x,cut_size.y),Vector2.ZERO)
			# 全ピクセル透明なセルは追加しない
			if new_img.get_used_rect() != Rect2i(0,0,0,0):
				row.append(new_img)
			else:
				# 空埋めする用
				row.append(null)
		res_array.append(row)
	
	return res_array

func blend_add(image:Image,src_image:Image) -> ImageTexture:
	var tex = ImageTexture.new()
	src_image.resize(image.get_width(), image.get_height())
	image.blend_rect(src_image,Rect2(0,0,image.get_width(), image.get_height()),Vector2.ZERO)
	tex.create_from_image(image)
	return tex
	
