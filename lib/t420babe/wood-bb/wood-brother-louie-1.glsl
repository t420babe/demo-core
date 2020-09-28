#ifndef T420BABE_WOOD_BROTHER_LOUIE_1
#define T420BABE_WOOD_BROTHER_LOUIE_1
// dca0477, 23:44 oh shit
// difference betwen wbl and wbl1 is how the wood grain moves
#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

float wbl1_random (in vec2 pos) {
	return fract(sin(dot(pos.xy,
					vec2(12.9898,78.233)))
			* 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float wbl1_noise(vec2 pos, float u_time) {
	vec2 i = floor(pos);
	vec2 f = fract(pos);
	vec2 u = f*f*(3.0-2.0*f);
	return mix( mix( wbl1_random( i + vec2(0.0,0.0) ),
				wbl1_random( i + vec2(1.0,0.0) ), u.x),
			mix( wbl1_random( i + vec2(0.0,1.0) ),
				wbl1_random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 wbl1_rotate2d(float angle){
	return mat2(cos(angle),-sin(angle),
			sin(angle),cos(angle));
}

float wbl1_lines(in vec2 pos, float b){
	float scale = 10.0;
	pos *= scale;
	return smoothstep(0.0,
			.5+b*.5,
			abs((sin(pos.x*3.1415)+b*2.0))*.5);
}

void wbl1_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {
	pos = square_position(pos);

	vec2 pos2 = pos.yx*vec2(10. * sin(u_time),10.);

	float pattern = pos2.x;
  float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

	// Add noise
	pos2 = wbl1_rotate2d( noise(pos2, u_time) ) * pos2;

	// Draw lines
	pattern = wbl1_lines(pos2,0.1);

	color = vec3(pattern);
	// return  vec3(color.x + sin(u_t) * 1.1, 0.9, color.x - 0.1);

	float size = 5.5;
	color += SHARP(wbl1_hexagon(pos * audio_ave * 4.0, size, audio));
	// color += SHARP(hexSDF(pos * rotate2d(full_ave * 0.1), full_ave));

	// if (full_max > 50.0  && full_max < 70.0) {
		if (audio.lowpass < 0.65) {
			color = vec3(0.8, color.g + exp_out(audio.lowpass) - 0.7, color.b + 0.4);
	}
}

#endif
