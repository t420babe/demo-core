// https://youtu.be/tdk9xlUtcc0
// #fav5 #feb
#ifndef T420BABE_AA_20
#define T420BABE_AA_20

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

vec3 aa_20_23(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos;
  vec3 color = vec3(1.0);

  float mul = 5.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.035;

  // float inv = (2.0 * res.y) / res.x;
  float inv = uv.y / uv.x;

  // vec2 uv = fragCoord.xy / iResolution.xy;

  vec3 col = vec4(uv,0.5+0.5*sin(time),1.0).xyz;

  vec3 texcol;

  float x = (center.x-uv.x) * inv * 0.5;
  float y = (center.y-uv.y) * inv * 0.1;

  float r = 1.0;
  r = -sqrt(x*x + y*y);
  // r *= -(x*x + y*y);
  float z = 1.0 + 0.5*sin((r+time*speed)/0.013);

  texcol.x = z;
  texcol.y = z;
  texcol.z = z;

  // color.r *= abs(audio.bandpass) * 1.2;
  // color.b *= abs(audio.notch) * 2.0;

  color =  color - texcol;
  color.g -= abs(audio.notch) * 0.05;
  color.b -= abs(audio.lowpass) * 0.05;
  color.g /= abs(audio.highpass) * 0.05;
  // color.b += abs(audio.highpass);
  // color = 1.0 - color;
  // color = color.bgr;
  // color = color.grb;
  return color;
}

vec3 aa_20_26(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos;
  vec3 color = vec3(1.0);

  float mul = 1.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.08;

  // float inv = (2.0 * res.y) / res.x;
  float inv = uv.y / uv.x;

  // vec2 uv = fragCoord.xy / iResolution.xy;

  vec3 col = vec4(uv,0.5+0.5*sin(time),1.0).xyz;

  vec3 texcol;

  float x = (center.x-uv.x);
  float y = (center.y-uv.y) *inv;

  float r = 1.0;
  r = -sqrt(x*x + y*y);
  r /= -(x*x + y*y);
  float z = 1.0 + 1.5*sin((r+time*speed)/0.013);

  texcol.x = z;
  texcol.y = y;
  texcol.z = z;

  // color.r *= abs(audio.bandpass) * 1.2;
  // color.b *= abs(audio.notch) * 2.0;

  color =  color - texcol;
  color = 0.8 - color;
  // color = 1.0 - color;
  // color = color.bgr;
  // color = color.grb;
  return color;
}

// ~1:57:15 - 2:03:27, it picks up at drop to be cool
// u_at = 1300
vec3 aa_20(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);

  float t = 0.4;

  vec3 color_0 = aa_20_26(pos.yx, u_at * 1.0, audio, u_resolution);
  vec3 color_1 = aa_20_23(pos, u_at * 1.0, audio, u_resolution);
  color = mix(color_1, color_0, t);

  return color;
}
#endif

