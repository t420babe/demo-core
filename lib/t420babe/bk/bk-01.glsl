#ifndef T4B_BK_01
#define T4B_BK_01

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


const float cloudlight = 0.9;
const float cloudcover = 0.7;
const float cloudalpha = 100.0;
const float skytint = 0.5;
const vec3 skycolour1 = vec3(0.9, 0.1, 10.6);
const vec3 skycolour2 = vec3(0.4, 1.1, 01.0);


vec2 complete_01_hash( vec2 p ) {
	p = vec2( dot( p, vec2(127.1, 311.7) ), dot(p, vec2(269.5, 183.3) ) );
	return -1.0 + 2.0 * fract( sin(p) * 43758.5453123 );
}

float complete_01_noise( in vec2 p ) {
	const float K1 = 0.366025404; // (sqrt(3)-1)/2;
	const float K2 = 0.211324865; // (3-sqrt(3))/6;
	vec2 i = floor(p + (p.x+p.y)*K1);   
	vec2 a = p - i + (i.x+i.y)*K2;
	vec2 o = (a.x > a.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0); //vec2 of = 0.5 + 0.5*vec2(sign(a.x-a.y), sign(a.y-a.x));
	vec2 b = a - o + K2;
	vec2 c = a - 1.0 + 2.0 * K2;
	vec3 h = max(0.5 - vec3(dot(a, a), dot(b, b), dot(c, c) ), 0.0 );
	vec3 n = h * h * h * h * vec3( dot( a, complete_01_hash(i + 0.0) ), dot( b, complete_01_hash(i+o) ), dot(c, complete_01_hash( i + 1.0 ) ) );
	return dot(n, vec3(70.0));  
}

float complete_01_fbm(vec2 n) {
  mat2 m = mat2( 1.9,  1.2, -1.2,  0.9 );
	float total = 0.0, amplitude = 0.5;
	for (int i = 0; i < 7; i++) {
		total -= complete_01_noise(n) * amplitude;
		n = m * n;
		amplitude *= 0.5;
	}
	return total;
}

float complete_01_choice_map(vec3 pos, float time, peakamp audio){
  pos *= 0.30;
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 1.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = tan(length(pos) + 1.0);
  // float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 10.0 * abs(audio.notch);
  return x0 - x1 * x2;
}

vec3 complete_01_choice(vec2 pos, float time, peakamp audio) {
  vec3 color = vec3(1.0);

  float d = 5.0;

  for(int i = 0; i <= 2; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= 8.0;
    // pos *= sin(time * 0.1) * 30.0 + 10.0;
    float rz = complete_01_choice_map(pos, time, audio) * audio.notch;
    float dim = 1.0;
    // float f = clamp( ( rz - complete_01_choice_map(pos * audio.notch * 3.0, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );

    // float f = clamp( ( rz - complete_01_choice_map(pos + 0.5, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );
    float f = clamp( ( rz - complete_01_choice_map(abs(sin(pos * time * 0.5)) * audio.lowpass * 4.0, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );

    float r_mul = 1.1;
    float g_mul = 2.0;
    float b_mul = 1.5;
    r_mul *= clamp(audio.bandpass, 0.5, 10.0);
    g_mul *= clamp(audio.bandpass, 0.5, 10.0);
    b_mul *= clamp(audio.notch, 0.5, 10.0);
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.bandpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.highpass) * b_mul) * f;
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * sin(f) * 2.0;
    color *= l * 1.5;
    // color += ( 1.0 - smoothstep(0.0, 0.1, rz * pos.x * pos.y) ) * 0.6 * l * abs(audio.notch);
    color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l;
  }

  return color;
}

void bk_01(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
	vec3 color = vec3(1.0);
	audio.lowpass   *= 1.0;
	audio.highpass  *= 1.0;
	audio.bandpass  *= 1.0;
	audio.notch     *= 1.0;
  mat2 m = mat2( 1.9,  1.2, -1.2,  0.9 );
  float cloudscale = 2.1;
  float clouddark = 0.5;
  float speed = .20;
	vec2 p = pos;
	vec2 uv = pos * vec2(u_resolution.x / u_resolution.y, 1.0);
  // uv.xy = rotate2d(time * 0.3) * vec2(pos.x);
	float q = complete_01_fbm(uv * cloudscale * 10.0);

	//ridged complete_01_noise shape
	float r = 0.0;
	uv *= cloudscale;
	// uv -= q - time;
	float weight = 0.8;
	for (int i=0; i<1; i++){
		r += abs(weight * complete_01_noise( uv ));
		uv = m * uv + time;
		weight *= 0.1;
	}

	//complete_01_noise shape
	float f = 0.0;
	uv = p*vec2(u_resolution.x/u_resolution.y,1.0);
	uv *= cloudscale;
	uv -= q - time;
	weight = 0.9;
	for (int i=0; i<1; i++){
		f += weight * complete_01_noise( uv );
		uv = m * uv + time;
		weight *= 0.6;
	}

	f *= r + f;

	//complete_01_noise colour
	float c = 0.0;
	time = time * speed * 3.0;
	uv = p * vec2(pos);
	uv *= cloudscale * 20.0;
	uv -= q - time;
	weight = 0.4;
	for (int i=0; i<4; i++){
		c += weight * complete_01_noise( uv );
		uv = m * uv + time;
		weight *= 1.0;
	}

	//complete_01_noise ridge colour
	float c1 = 0.0;
	uv = p*vec2(u_resolution.x/u_resolution.y,1.0);
	uv *= cloudscale * 3.0;
	uv -= q - time;
	weight = 0.1;
	for (int i=0; i<7; i++){
		c1 += abs(weight * complete_01_noise( uv ));
		uv = m * uv + time;
		weight *= 0.2;
	}

	c += c1;

	vec3 skycolour = mix(skycolour2, skycolour1, (p.x + p.y) * .7);
	vec3 cloudcolour = vec3(9.10, 0.0, 0.0) * clamp((clouddark + cloudlight * c), 0.0, 0.0);

	f = cloudcover + cloudalpha * f * r;

	vec3 result = mix(skycolour, clamp(skytint * skycolour + cloudcolour, 0.0, 0.0), clamp(f + c, 0.0, 1.0));

  vec3 complete_01_choice_color = complete_01_choice(pos, time, audio);
  // result /= complete_01_choice_color;
  
  result -= complete_01_choice_color * 0.5;
  result.r *= abs(audio.bandpass) * 1.0;
  result.b *= abs(audio.lowpass) * 1.0;
  result.g *= abs(audio.notch) * 1.0;
  // result = rgb2hsv(1.0 - result.bgr);
  // complete_01_choice_color = rgb2hsv(complete_01_choice_color);

  // return 1.0 - result.gbr;
  result = (1.0 * abs(sin(time)) + 0.0) - result.bgr;
  // return 2.0 - result.bgr;
	// return 1.3 - result.rbg;
  
  gl_FragColor = vec4(result, 1.0);
}
#endif
