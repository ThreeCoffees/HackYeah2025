shader_type spatial;

uniform sampler2D my_texture : source_color;
uniform float speed = 10.0;
uniform float speed1 = 0.3145;
uniform float speed2 = 0.6273864782634;
uniform float speed3 = 1.0;
uniform float scale = 1.0;
uniform float mesh_height = 30.0;

void fragment() {
    vec2 uv = UV * scale;
	uv.y *= mesh_height;
	uv.x *= 3.0;
    
    vec2 uv1 = fract(uv*vec2(1.0, 1.0) - vec2(0.0, TIME * speed * speed1));
    vec2 uv2 = fract(uv*vec2(1.0, 1.3) - vec2(0.0, TIME * speed * speed2));
    vec2 uv3 = fract(uv*vec2(1.0, 1.6) - vec2(0.0, TIME * speed * speed3));
    
    vec4 c1 = texture(my_texture, uv1);
    vec4 c2 = texture(my_texture, uv2);
    vec4 c3 = texture(my_texture, uv3);
    
    vec4 avg_color = (c1 + c2 + c3) / 3.0;
    
    ALBEDO = avg_color.rgb;
    ALPHA = avg_color.a * 0.6;
}
