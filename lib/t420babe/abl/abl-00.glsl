#ifndef T4B_ABL_00
#define T4B_ABL_00

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_RGB_HSV
#include "./lib/common/rgb-hsv.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


// Forked from @ spsherk_ 
// https://www.shadertoy.com/view/3dsGDr


const float cloudscale = 2.1;
const float speed = .20;
const float clouddark = 0.5;
const float cloudlight = 0.9;
const float cloudcover = 0.7;
const float cloudalpha = 100.0;
const float skytint = 0.5;
const vec3 skycolour1 = vec3(0.9, 0.1, 10.6);
const vec3 skycolour2 = vec3(0.4, 1.1, 01.0);

const mat2 m = mat2( 1.9,  1.2, -1.2,  0.9 );

vec2 hash( vec2 p ) {
	p = vec2( dot( p, vec2(127.1, 311.7) ), dot(p, vec2(269.5, 183.3) ) );
	return -1.0 + 2.0 * fract( sin(p) * 43758.5453123 );
}

float noise( in vec2 p ) {
	const float K1 = 0.366025404; // (sqrt(3)-1)/2;
	const float K2 = 0.211324865; // (3-sqrt(3))/6;
	vec2 i = floor(p + (p.x+p.y)*K1);   
	vec2 a = p - i + (i.x+i.y)*K2;
	vec2 o = (a.x > a.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0); //vec2 of = 0.5 + 0.5*vec2(sign(a.x-a.y), sign(a.y-a.x));
	vec2 b = a - o + K2;
	vec2 c = a - 1.0 + 2.0 * K2;
	vec3 h = max(0.5 - vec3(dot(a, a), dot(b, b), dot(c, c) ), 0.0 );
	vec3 n = h * h * h * h * vec3( dot( a, hash(i + 0.0) ), dot( b, hash(i+o) ), dot(c, hash( i + 1.0 ) ) );
	return dot(n, vec3(70.0));  
}

float fbm(vec2 n) {
	float total = 0.0, amplitude = 0.5;
	for (int i = 0; i < 7; i++) {
		total -= noise(n) * amplitude;
		n = m * n;
		amplitude *= 0.5;
	}
	return total;
}

void abl_00(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
	vec3 color = vec3(1.0);
	audio.lowpass   *= 1.0;
	audio.highpass  *= 1.0;
	audio.bandpass  *= 1.0;
	audio.notch     *= 1.0;
	vec2 p = pos;
	vec2 uv = pos * vec2(u_resolution.x / u_resolution.y, 1.0);
	// float time = time * speed;
	float q = fbm(uv * cloudscale * 0.5);

	//ridged noise shape
	float r = 0.0;
	uv *= cloudscale;
	uv -= q - time;
	float weight = 0.8;
	for (int i=0; i<1; i++){
		r += abs(weight*noise( uv ));
		uv = m*uv + time;
		weight *= 0.7;
	}

	//noise shape
	float f = 0.0;
	uv = p*vec2(u_resolution.x/u_resolution.y,1.0);
	uv *= cloudscale;
	uv -= q - time;
	weight = 0.9;
	for (int i=0; i<1; i++){
		f += weight * noise( uv );
		uv = m * uv + time;
		weight *= 0.6;
	}

	f *= r + f;

	//noise colour
	float c = 0.0;
	time = time * speed * 3.0;
	uv = p * vec2(pos);
	uv *= cloudscale * 20.0;
	uv -= q - time;
	weight = 0.4;
	for (int i=0; i<4; i++){
		c += weight * noise( uv );
		uv = m * uv + time;
		weight *= 1.0;
	}

	//noise ridge colour
	float c1 = 0.0;
	time = time * speed * 3.0;
	uv = p*vec2(u_resolution.x/u_resolution.y,1.0);
	uv *= cloudscale*3.0;
	uv -= q - time;
	weight = 0.1;
	for (int i=0; i<7; i++){
		c1 += abs(weight*noise( uv ));
		uv = m*uv + time;
		weight *= 0.2;
	}

	c += c1;

	vec3 skycolour = mix(skycolour2, skycolour1, (p.x + p.y) * .7);
	vec3 cloudcolour = vec3(9.10, 0.0, 0.0) * clamp((clouddark + cloudlight * c), 0.0, 0.0);

	f = cloudcover + cloudalpha * f * r;

	vec3 result = mix(skycolour, clamp(skytint * skycolour + cloudcolour, 0.0, 0.0), clamp(f + c, 0.0, 1.0));
  
  // result.r /= abs(audio.bandpass) * 40.0;
  result.b /= abs(audio.lowpass) * 30.0;
  result.g /= abs(audio.notch) * 10.0;
  result = rgb2hsv(0.5 - result);

  gl_FragColor = vec4(result, 1.0);
}
#endif
