// #fav5 #feb
#ifndef T420BABE_ADDICTED_08
#define T420BABE_ADDICTED_08

#ifndef COMMON_TRANS
#include "./lib/common/trans.glsl"
#endif


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

vec3 addicted_08_00(vec2 pos, float u_time, peakamp audio, vec2 res) {
  vec2 uv = pos;
  uv *= 3.5;
  vec3 color = vec3(1.0);

  float mul = 2.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.10;
  float invAr = (1.5 * res.y) / res.x;

  vec3 texcol;

  float x = (center.x + sin(uv.x));
  float y = (center.y - sin(uv.x * uv.y)) *invAr;

  //float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
  float r = -(x*x * y*y);
  float z = 0.0 + 0.5*sin((r+u_time*speed)/0.013);

  texcol.x = z;
  texcol.y = z;
  texcol.z = z;

  color *= texcol;
  color.r *= abs(audio.notch * 3.0);
  color.g *= abs(sin(u_time));

  return color;
}

vec3 addicted_08_05(vec2 pos, float u_time, peakamp audio, vec2 res) {
  vec2 uv = pos.yx;
  uv *= 7.0;
  vec3 color = vec3(1.0);

  float mul = 2.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.10;
  float invAr = (1.5 * res.y) / res.x;

  vec3 texcol;

  float x = (center.x + sin(uv.x));
  float y = (center.y - sin(uv.x * uv.y)) *invAr;

  //float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
  float r = (x*x - y*y);
  float z = 0.0 + 0.5*sin((r+u_time*speed)/0.013);

  texcol.x = z;
  texcol.y = z;
  texcol.z = z;

  color *= texcol;
  // color.r *= abs(audio.bandpass * 2.0);
  // color.g *= abs(sin(u_time) );
  // color.b *= abs(audio.notch * 2.0);
  color.g *= abs(audio.bandpass * 2.0) + 0.2;
  color.b *= abs(sin(u_time) * audio.lowpass * 2.0 + 0.3);
  color.r *= abs(audio.notch * 3.5) + 0.2;

  return color;
}

vec3 addicted_08(vec2 pos, float u_time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t;
  float start = 00.0;
  float end = 20.0;

  t = trans(u_at, start, end);
  t = wrap_time(u_time * 0.1, 1.0);
  // t = 0.5;

  color_0 = addicted_08_05(pos, u_at, audio, u_resolution);
  color_1 = addicted_08_00(pos, u_at, audio, u_resolution);
  color = mix(color_0, color_1, t);

  color = color.rbg;


  return color;
}
#endif


