shader_type canvas_item;

uniform float offset = 0.0;

void vertex() {
	
}

void fragment() {
	vec4 pixel = texture(TEXTURE, SCREEN_UV - offset);
	COLOR = pixel;
}
