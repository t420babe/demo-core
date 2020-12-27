// #effect #effectshape #fav5 #shadershoot #corey #needsvid #rosebutt #rosebud
// ENG98 - Extended Mix by Monki
#ifndef T420BABE_MISX_06
#define T420BABE_MISX_06

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

vec2 hills_spherical_vortex(vec2 pos, float u_time) {
  float a = 1.0;
  float u_0 = 15.0;
  float A = 15.0 / 2.0 * u_0 * 1.0 / pow(a, 2.0);

  float u_int = 1.0 / 5.0 * A * pos.y * (pow(a, 2.0) - pow(pos.x, 2.0) - 2.0 * pow(pos.y, 2.0));
  float v_int = 1.0 / 5.0 * A * pos.x * pos.y;

  return vec2(sin(u_int), tan(v_int));
}

float random (in vec2 pos) {
    return fract( sin( dot( pos, vec2(12.9898, 78.233) ) ) * 43758.5453123);
}

float vc(vec2 pos, float u_time, peakamp audio) {
  pos.x += 0.5;
  vec2 uv_int = hills_spherical_vortex(pos, u_time);
  float z = (1.0 * uv_int.x + 1.0 * uv_int.y) / 5.0 + 2.0;

  float time_wrap = wrap_time(u_time, 30.0);
  z *= 1.0 * (time_wrap / 5.0);
  float d = fract(z);
  if(mod(z, 2.0) > 1.0) d = 1.0 -d;

  // d = d / fwidth(z);
  d = sharp(d);
  return d;
}


void vortex_contour(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  vec2 uv_int = hills_spherical_vortex(pos, u_time);
  float z = (1.0 * uv_int.x + 1.0 * uv_int.y) / 5.0 + 2.0;

  float time_wrap = wrap_time(u_time, 30.0);
  z *= 4.0 * (time_wrap / 5.0);
  float d = fract(z);
  if(mod(z, 2.0) > 1.0) d = 1.0 -d;

  // d = d / fwidth(z);
  d = sharp(d);
  color = vec3(d);
  // color = 1.0 - color;
}

// Value noise by Inigo Quilez - iq/2013, https://www.shadertoy.com/view/lsf3WH
float noise(vec2 pos) {

  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f * f * (3.0 - 2.0 * f);
  return mix(
      mix( random( i + vec2(0.0, 0.0) ), random( i + vec2(1.0, 0.0) ), u.x),
      mix( random( i + vec2(0.0, 1.0) ), random( i + vec2(1.0, 1.0) ), u.x),
      u.y);
}

float shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass);
  // float r = length(pos) * 2.0;
  // float theta = atan(pos.y, pos.x);
  float theta = pos.y  * pos.x + audio.notch;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  m += noise( pos + u_time * 0.1) * 5.1;
  f += (-pos.x * pos.x);
  // f += noise(pos + u_time * 1.0) * 0.1;
  // f1 /= (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  // f1 += sin(theta * 20.0) * 0.1 * pow(m, 2.0);
  f1 = vc(pos, u_time, audio);

  // return 1.0 - smoothstep(f, f + 0.007, r);
  // return 1.0 - smoothstep(f, f + 0.507, r) / fwidth(f1);
  return 1.0 - smoothstep(f1, f + 1.007, r) / fwidth(f);
  // float tt = 1.0 - smoothstep(f, f + 0.107, r) / fwidth(f1);
  // return tt;
}

float shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return shape(pos, radius, u_time, audio) - shape(pos, radius - width, u_time, audio);
}

void misx_06(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;
  // pos = pos.yx;

  // shape_color_border(pos, 1.0, 0.10, u_time, audio, color);

  // // Color 0
  // color /= shape_border(pos, 1.0, 0.10, u_time, audio);
  // color.r /= sin(audio.lowpass * 0.5);
  // color.b *= audio.lowpass * 1.0;

  // Color 0
  color.b += audio.lowpass * 1.0;
  color *= shape_border(pos, 3.0, 0.01, u_time, audio);
  color.b *= abs(audio.highpass) * 1.0;
  // color.r *= audio.lowpass * 1.0;
  // color.r -= audio.lowpass * 1.0;

  // color = vec3(0.843, 0.6243, 0.245) - color;
  // color = vec3(0.843, 0.6243, 0.645) - color;
  // color = vec3(0.943, 0.5243, 0.145) - color;
  color = vec3(0.843, 0.6243, 0.645) - color;

  // color = 1.0 - color;
}
#endif
