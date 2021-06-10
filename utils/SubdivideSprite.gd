tool
extends Node2D
class_name SubdivideSprite

export(Texture) var texture setget set_texture, get_texture
export var resolution = 4 setget set_resolution, get_resolution
export var debug_draw = false setget set_debug_draw

func get_texture():
	return texture

func set_texture(tex):
	texture = tex
	update()

func get_resolution():
	return resolution

func set_resolution(res):
	if res < 1 or res > 32:
		return
	resolution = res
	update()

func set_debug_draw(dd):
	debug_draw = dd
	update()

func _draw():
	if texture == null:
		return
	var tex_size = texture.get_size()
	var div_size = tex_size / Vector2(resolution, resolution)

	draw_set_transform(-tex_size / 2.0, 0.0, Vector2(1, 1))

	for y in range(0, resolution):
		for x in range(0, resolution):
			var pos = Vector2(x, y)
			var r = Rect2(pos * div_size, div_size)
			draw_texture_rect_region(texture, r, r)

	if debug_draw and Engine.editor_hint:
		# Debug draw
		for y in range(0, resolution):
			for x in range(0, resolution):
				var pos = Vector2(x, y)
				var r = Rect2(pos * div_size, div_size)
				stroke_rect(r, Color(1, 1, 0, 0.5))


func stroke_rect(r, c):
	draw_line(r.position, Vector2(r.position.x, r.position.y), c)
	draw_line(r.position, Vector2(r.position.x, r.end.y), c)
	draw_line(r.end, Vector2(r.end.x, r.position.y), c)
	draw_line(r.end, Vector2(r.position.x, r.end.y), c)
