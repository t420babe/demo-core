#ifndef T420BABE_CATERPILLAR
#define T420BABE_CATERPILLAR
// e7dc6620, 19:05 yes thatstrippydude

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

float wbl5_random (in vec2 pos) {
  return fract((dot(pos.xy,
          vec2(12.9898,78.233)))
      * 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float wbl5_noise(vec2 pos, float u_time) {
  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f*f*(3.0-2.0*f);
  return mix( mix( wbl5_random( i + vec2(0.0,0.0) ),
        wbl5_random( i + vec2(1.0,0.0) ), u.x),
        mix( wbl5_random( i + vec2(0.0,1.0) ),
        wbl5_random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 wbl5_rotate2d(float angle){
  return mat2(cos(angle),-sin(angle),
      sin(angle),cos(angle));
}

float wbl5_lines(in vec2 pos, float b){
  float scale = 10.0;
  pos *= scale;
  return smoothstep(0.0,
      .5+b*.5,
      abs((sin(pos.x*3.1415)+b*2.0))*.5);
}

void caterpillar(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  vec2 pos2 = pos.yx;

  float pattern = pos2.x;
  float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

  // Add noise
  pos2 = wbl5_rotate2d( wbl5_noise(pos2, u_time) ) * pos2;

  // Draw lines
  pattern = wbl5_lines(pos2,0.1);

  color = vec3(pattern);

  vec2 rect_size = vec2(1.5, 1.5);
  // color -= rect_sdf(pos + vec2(0.5), rect_size);
	// color -= rect_sdf(pos + vec2(0.5), rect_size * audio_ave * 1.5);
	// float a = (audio.lowpass + audio.notch) / udio.bandpass2.0;
	color -= rect_sdf(pos + vec2(0.5), (rect_size * audio.bandpass) + (audio.notch * 3.0));

	// float size = 2.5;
	// color -= (wbl1_hexagon(pos * audio_ave * 4.0, size, audio));

	// if (audio.lowpass < 0.65) {
		color = vec3(color.r - 0.3, color.g - 0.6, color.b + 0.4);
	// }
}

#endif

