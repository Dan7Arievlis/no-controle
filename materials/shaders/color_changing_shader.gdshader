shader_type canvas_item;

uniform vec4 color : source_color;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	vec4 grayScale = vec4(pixelColor.r, pixelColor.r, pixelColor.r, pixelColor.a);
	COLOR = grayScale / (1.0 - color);
}
