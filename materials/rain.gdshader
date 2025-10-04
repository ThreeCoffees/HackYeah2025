shader_type spatial;

uniform sampler2D droplet : source_color;
uniform uint seed = 1;
uniform float speed = 5;
uniform vec2 scale = vec2(1.0);
uniform vec4 tex_col_mult = vec4(1.0);
uniform float visibility = 0;

#define hash(x)  ( float( hashi(x) ) / float( 0xffffffffU ) )

uint hashi(uint x) {
    x ^= x >> uint(16);
    x *= 0x7feb352dU;
    x ^= x >> uint(15);
    x *= 0x846ca68bU;
    x ^= x >> uint(16);
    return x;
}

float rand(uvec2 x) {
	return hash(x.x + hashi(x.y));
}

void fragment() {
    vec2 uv = UV * scale * 7.0;
	uv.y *= 2.0;
    uv.y -= (TIME - float(0xfff)) * speed * 9.0;
    uvec2 num = uvec2(uv) * seed;
    
    // Wrap the UVs so the texture repeats seamlessly
	uv = fract(uv);
	
	float chance = rand(num);
	if (chance > visibility/3.0) {
		discard;
	}
	
	vec2 kick = (vec2(rand(num+1U), rand(num+2U)) - 0.5)*5.0;
    
    vec4 tex_color = texture(droplet, clamp(kick + uv*4.0, vec2(0.0), vec2(1.0))) * tex_col_mult;
    
    // Output the texture color as the material's albedo (diffuse)
    ALBEDO = tex_color.rgb;
    ALPHA = tex_color.a;
}
