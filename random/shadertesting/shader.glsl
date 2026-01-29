extern float time;
extern float resX;
extern float resY;

float sdStar5(in vec2 p, in float r, in float rf)
{
	const vec2 k1 = vec2(0.809016994375, -0.587785252292);
	const vec2 k2 = vec2(-k1.x,k1.y);
	p.x = abs(p.x);
	p -= 2.0*max(dot(k1,p),0.0)*k1;
	p -= 2.0*max(dot(k2,p),0.0)*k2;
	p.x = abs(p.x);
	p.y -= r;
	vec2 ba = rf*vec2(-k1.y,k1.x) - vec2(0,1);
	float h = clamp( dot(p,ba)/dot(ba,ba), 0.0, r );
	return length(p-ba*h) * sign(p.y*ba.x-p.x*ba.y);
}

vec3 palette( in float t)
{
	vec3 a = vec3(0.107, 0.184, 0.261);
	vec3 b = vec3(0.876, 0.423, 0.108);
	vec3 c = vec3(0.510, 1.189, 1.079);
	vec3 d = vec3(3.874, 3.712, 0.647);

	return a + b*cos( 6.28318*(c*t+d) );
}

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ) {
	// Normalized pixel coordinates (from 0 to 1)
	vec2 uv = screen_coords * 2.0;
	uv.x = uv.x - resX;
	uv.y = uv.y - resY;
	uv = uv / resY;

	float d = sdStar5( uv, 1.0, 0.5 );
	vec3 col = palette(d + time / 10.0);
	
	d = sin(d * 24.0 + time * 2.0)/12.0;
	d = abs(d);
	d = 0.05 / d;
	
	col *= d;
	
	// Output to screen
	return vec4(col,1.0);
}
