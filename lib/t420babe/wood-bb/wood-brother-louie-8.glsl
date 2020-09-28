#ifndef T420BABE_WOOD_BROTHER_LOUIE_8
#define T420BABE_WOOD_BROTHER_LOUIE_8

// 8d6adf64, 00:11
#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

float wbl8_random (in vec2 pos) {
  return fract((dot(pos.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013, https://www.shadertoy.com/view/lsf3WH
float wbl8_noise(vec2 pos, float u_time) {
  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f*f*(3.0-2.0*f);
  return mix( mix( wbl8_random( i + vec2(0.0,0.0) ), wbl8_random( i + vec2(1.0,0.0) ), u.x),
        mix( wbl8_random( i + vec2(0.0,1.0) ), wbl8_random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 wbl8_rotate2d(float angle){
  return mat2(tan(angle), sin(angle), cos(angle), -sin(angle));
}

float wbl8_lines(in vec2 pos, float b){
  float scale = 10.0;
  pos *= scale;
  return smoothstep(0.0, 0.5 + b * 0.5, abs((fract(pos.x * 3.1415) + b * 2.0)) * 0.5);
}

// Ya know by Mat.Joe
void wbl8_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  vec2 pos2 = pos.yx * vec2(10.0 * fract(u_time), 10.0);

  float pattern = pos2.x;
  float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

  // Add noise
  pos2 = wbl8_rotate2d( noise(pos2, u_time) ) * pos2;

  // Draw lines
  pattern = wbl8_lines(pos2, pos.y * pos.y);

  color = vec3(pattern);

  float size = 5.5;
  color += SHARP(wbl1_hexagon(pos * audio_ave * 4.0, size, audio));

  if (audio.lowpass < 0.65) {
    color = vec3(0.8, color.g - 0.4, color.b - 0.1290384);
  }
}

#endif
