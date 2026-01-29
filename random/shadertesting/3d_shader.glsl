#define PI 3.14159265359
#define TWO_PI PI * 2.0

float iResolutionX = 800.0;
float iResolutionY = 600.0;
extern float time;

// Edge smoothing
const float SMOOTHING = 256.0;

// Rainbow start colour
const vec3 startColour = vec3(1.0, 0.0, 0.0);

float battery = 1.0;
float block_size = 0.2;
float anchor = -5.0;
float speed = 4.0;
float speed_h = 1.5;
float blocks_offset_h = 2.0;
float distortion = 0.07;
float height = 5.0;
float fov = 1.0;
vec4 col_bg = vec4(1.0);
vec4 col_grid = vec4(0.77, 0.77, 0.77, 1.0);



float grid( in vec2 uv, in float batt ) {
    vec2 size = vec2(uv.y, uv.y * uv.y * 0.2) * 0.01;
    
    uv.y += time * speed * (batt + 0.01);
    uv = abs(fract(uv)) - 0.5;
    
    // repeat on both sides
    uv.x = abs(fract(uv.x));
    
    vec2 lines = step(size, vec2(0.0));
    lines += step(size, uv * 8.0) * 0.5 * batt;
    
    return clamp(lines.x + lines.y, 0.5, 2.0);
}


vec2 rotateUV(vec2 uv, float rotation)
{
    float mid = 0.5;
    return vec2(
        cos(rotation) * (uv.x - mid) + sin(rotation) * (uv.y - mid) + mid,
        cos(rotation) * (uv.y - mid) - sin(rotation) * (uv.x - mid) + mid
    );
}

vec2 rotateUV(vec2 uv, float rotation, vec2 mid)
{
    return vec2(
      cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
      cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
    );
}

vec2 rotateUV(vec2 uv, float rotation, float mid)
{
    return vec2(
      cos(rotation) * (uv.x - mid) + sin(rotation) * (uv.y - mid) + mid,
      cos(rotation) * (uv.y - mid) - sin(rotation) * (uv.x - mid) + mid
    );
}

#pragma glslify: export(rotateUV)


const mat3 YIQ_CONVERT = mat3(
    0.299, 0.596, 0.211,
    0.587, -0.274, -0.523,
    0.114, -0.322, 0.312
);
 
const mat3 RGB_CONVERT = mat3(
    1.0, 1.0, 1.0,
    0.956, -0.272, -1.106,
    0.621, -0.647, 1.703
);
 
vec3 ToYIQ(vec3 colour)
{
    return YIQ_CONVERT * colour;
}
 
vec3 ToRGB(vec3 colour)
{
    return RGB_CONVERT * colour;
}
 
vec3 HueShift(vec3 colour, float shift)
{
    vec3 yiq = ToYIQ(colour);
  
    mat2 rotMatrix = mat2(
        cos(shift), -sin(shift),
        sin(shift), cos(shift)
    );
    yiq.yz *= rotMatrix;
  
    return ToRGB(yiq);
}

// https://easings.net/#easeInOutCubic
float EaseInOutCubic(float x)
{
    return x < 0.5 ? 4.0 * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 3.0) / 2.0;
}
 
vec3 EaseInOutCubic(vec3 rgb)
{
    rgb.r = EaseInOutCubic(rgb.r);
    rgb.g = EaseInOutCubic(rgb.g);
    rgb.b = EaseInOutCubic(rgb.b);
    return rgb;
}


vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = texture_coords * 10.0;//where does this come from ??!??!?!
    
    
    vec3 rgb = EaseInOutCubic(HueShift(startColour, uv.y * TWO_PI));
    
    float w = 1.0 / min(iResolutionX, iResolutionY);
 
    float s = SMOOTHING * w;
    rgb = smoothstep(-s, s, rgb);
    vec4 rainbow = vec4(rgb.r, rgb.g, rgb.b, 1.0);
    
	vec4 col = col_bg;
    uv.y = 3.0 - uv.y;
    
    // what the fuck ::D:D:::D:D:D
    uv = rotateUV(uv, cos(time), 0.5);
    
	uv.y = height / (abs(uv.y + fov) + 0.05);
    uv.x += anchor;
	uv.x *= uv.y * block_size;
	
	// Crazy perspective effect
	//uv.x *= uv.y;
	
	// Forwards movement
	uv.x += time * speed_h;
	
	// Make flag grid pattern by offsettign blocks with fract
	uv.y += fract(float(int(uv.x*2.0))/blocks_offset_h);
	
	if (uv.x >= 0.0) {
		uv.y -= 0.5;
	}
	
    
	// Wave motion
	vec2 distortedUV = uv;
	distortedUV.y += sin(distortedUV.x * 2.5 + time*10.0) * distortion;
	
	float gridVal = grid(distortedUV, battery);
	vec4 cool = vec4(sin(time), cos(time * uv.x * uv.y), sin(time), 1.0);
    
	col = mix(col_grid, col_bg, gridVal);
	
	return col;
}
