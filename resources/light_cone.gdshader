shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform vec3 color = vec3(0.2, 0, 0.5);
uniform float max_alpha = 0.6;

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	COLOR.a = min(texture(TEXTURE, UV).a, max_alpha);
	COLOR.rgb += color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
