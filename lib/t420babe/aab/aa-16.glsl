// #fav5 #feb
#ifndef T420BABE_AA_16
#define T420BABE_AA_16

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_TRANS
#include "./lib/common/trans.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

vec3 aa_16_12(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos.yx;
  uv *= 15.0;
  vec3 color = vec3(1.0);

  float mul = 3.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.8;
  float icoord = (1.5 * uv.y) / uv.x;

  vec3 texcol;

  float x = (center.x + sin(uv.x));
  float y = (center.y - sin(uv.x * uv.y)) * icoord;

  // //float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
  float r = exp(x*x - y*y);
  float z = 0.0 + 0.5 * cos( (r + time * speed) / 0.513);

  texcol.x = z;
  texcol.y = z;
  texcol.z = z;

  color *= texcol;
  // color.r *= abs(audio.bandpass * 2.0);
  // color.g *= abs(sin(time) );
  // color.b *= abs(audio.notch * 2.0);
  color.g *= abs(audio.bandpass * 2.5) + 0.2;
  color.b *= abs(sin(time) * audio.lowpass * 2.5 + 0.3);
  color.r *= abs(audio.notch * 2.5) + 0.2;

  color = 0.5 - color;
  color = color.grb;

  return color;
}

vec3 aa_16_15(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos * sin(u_time * 0.08) + 0.5;
  uv.x -= 0.1;
  uv.y -= 0.5;
  uv *= 15.0;
  vec3 color = vec3(1.0);

  float mul = 3.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 5.0;
  float icoord = (1.5 * uv.y) / uv.x;
  // uv /= 3.0;

  vec3 texcol;

  float x = (center.x + sin(uv.x + 2.0));
  float y = (center.y - tan(uv.x * uv.y)) * icoord;

  // //float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
  float r = exp(x*x - y*y);
  float z = 0.0 + 0.5 * cos( (r + time * speed) / 0.513);

  texcol.x = z * abs(cos(u_time));
  texcol.y = z * 2.0;
  texcol.z = z * 0.5;

  color *= texcol;
  color.r *= abs(audio.bandpass * 2.0);
  color.g *= abs(sin(time) );
  color.b *= abs(audio.notch * 2.0);
  color.g *= abs(audio.bandpass * 2.5) + 0.2;
  color.b *= abs(sin(time) * audio.lowpass * 2.5 + 0.3);
  color.r *= abs(audio.notch * 2.5) + 0.2;

  // color = 0.5 - color;
  color = color.bgr;

  return color;
}

vec3 aa_16(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t;
  float start = 00.0;
  float end = 20.0;

  t = trans(time, start, end);
  t = wrap_time(time * 0.1, 1.0);
  color_0 = aa_12(pos, time, audio, u_resolution);
  color_1 = aa_15(pos.yx, time, audio, u_resolution);
  color = mix(color_0, color_1, t);
  return color;
}
#endif

