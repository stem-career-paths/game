// From https://github.com/godotengine/godot-demo-projects/blob/3.5-9e68af3/2d/sprite_shaders/shaders/blur.shader
// by way of https://www.reddit.com/r/godot/comments/12cb1t2/how_to_blur_a_sprite/
//
// Godot demo project licensed under MIT license.
shader_type canvas_item;
render_mode blend_mix;

uniform float radius = 2.0;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	vec2 ps = TEXTURE_PIXEL_SIZE;

	col += texture(TEXTURE, UV + vec2(0.0, -radius) * ps);
	col += texture(TEXTURE, UV + vec2(0.0, radius) * ps);
	col += texture(TEXTURE, UV + vec2(-radius, 0.0) * ps);
	col += texture(TEXTURE, UV + vec2(radius, 0.0) * ps);
	col /= 5.0;

	COLOR = col;
}