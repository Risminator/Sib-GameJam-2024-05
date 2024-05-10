shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	COLOR.a = min(texture(TEXTURE, UV).a, 0.5);
	COLOR.rgb += vec3(0.2, 0, 0.5);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
