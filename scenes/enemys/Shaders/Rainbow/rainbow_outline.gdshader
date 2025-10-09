shader_type canvas_item;

uniform float line_thickness : hint_range(0, 20) = 1.0;
uniform float sin_frequency : hint_range(0.1, 2.0) = 0.5;
uniform float sin_offset : hint_range(0.0, 360.0) = 0.0;
uniform float light_offset : hint_range(0.0, 1.0) = 0.5;


void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	
	float outline = texture(TEXTURE, UV + vec2(-size.x,0)).a;
	outline += texture(TEXTURE, UV + vec2(0,size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x,0)).a;
	outline += texture(TEXTURE, UV + vec2(0,-size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x,size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x,size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x,-size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x,-size.y)).a;
	outline = min(outline,1.0);
	
	vec4 animated_line_color = vec4(light_offset + sin(2.0*3.14*sin_frequency*TIME),
								light_offset + sin(2.0*3.14*sin_frequency*TIME + radians(120.0)),
								light_offset + sin(2.0*3.14*sin_frequency*TIME + radians(240.0)),
								1.0);
	
	
	vec4 color = texture(TEXTURE, UV);
	COLOR = mix(color,animated_line_color,outline - color.a);
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
