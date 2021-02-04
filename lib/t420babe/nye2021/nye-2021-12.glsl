#ifndef T420BABE_NYE_2021_12
#define T420BABE_NYE_2021_12

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

vec2 nye_2021_12_hills_spherical_vortex(vec2 pos, float u_time) {
  float a = 1.0;
  float u_0 = 10.0;
  float A = 15.0 / 2.0 * u_0 * 1.0 / pow(a, 2.0);

  float u_int = 1.0 / 5.0 * A * pos.y * (pow(a, 2.0) - pow(pos.x, 2.0) - 2.0 * pow(pos.y, 2.0));
  float v_int = 1.0 / 5.0 * A * pos.x * pos.y;

  return vec2(u_int, v_int);
}

float nye_2021_12_vc_nyc(vec2 pos, float u_time, peakamp audio) {
  pos = pos.xy;
  pos.x += 5.0 * (sin(u_time * 0.5));
  vec2 uv_int = nye_2021_12_hills_spherical_vortex(pos, u_time);
  float z = (1.0 / uv_int.x + 1.0 * uv_int.y) / 5.0 + 2.0;

  float time_wrap = wrap_time(u_time, 10.0);
  z *= 10.0 * (time_wrap / 5.0);
  float d = fract(z * 5.0);
  if(mod(z, 2.0) > 1.0) d = 1.0 -d;

  // d = d / fwidth(z);
  d = fract(d);
  return d;
}

float nye_2021_12_shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass);
  // float r = length(pos) * 2.0;
  // float theta = atan(pos.y, pos.x);
  float theta = pos.y  * pos.x + audio.notch;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  m += noise( pos + u_time * 0.1) * 0.5;
  f += noise(pos + u_time * 1.0) * 0.1;
  // f1 /= (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  // f1 += sin(theta * 20.0) * 0.1 * pow(m, 2.0);
  f1 = nye_2021_12_vc_nyc(pos, u_time, audio);

  // return 1.0 - smoothstep(f1, f + 1.007, r) / fwidth(f1);
  return 1.0 - sharp(smoothstep(f1, f + 1.007, r) );
}

float nye_2021_12_shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return nye_2021_12_shape(pos, radius, u_time, audio) - nye_2021_12_shape(pos, radius - width, u_time, audio);
}

vec3 nye_2021_12(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 2.0;
  audio.highpass  *= 2.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 2.0;

  color.g += audio.lowpass * 1.0;
  // color *= nye_2021_12_shape_border(pos, 5.0, 4.00, u_time, audio);
  color *= nye_2021_12_shape_border(pos, 3.0, 1.00, u_time, audio);
  color.b *= abs(audio.highpass * 1.0);
  color.g -= abs(audio.lowpass * 1.0);

  color = color.gbr;
  // color = 1.0 - color;
  return color;
}
#endif
