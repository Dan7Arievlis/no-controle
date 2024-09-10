shader_type canvas_item;

uniform vec4 overlay: source_color;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	//vec4 overlay_sample = texture(overlay, SCREEN_UV);
	vec4 screen_sample = texture(screen_texture, SCREEN_UV);

	vec4 grayScale = vec4(screen_sample.r, screen_sample.r, screen_sample.r, screen_sample.a);
	COLOR = grayScale / (1.0 - overlay);
}