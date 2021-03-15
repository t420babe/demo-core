// #fav5 #feb
#ifndef T420BABE_ADDICTED_29
#define T420BABE_ADDICTED_29

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

vec3 addicted_29_12(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos.yx;
  uv *= 15.0;
  vec3 color = vec3(1.0);

  float mul = 1.5;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 1.5;
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
  // color.b *= abs(audio.notch * 1.0);
  color.g *= abs(audio.bandpass * 2.5);
  color.b *= abs(sin(time) * audio.lowpass * 2.5);
  color.r *= abs(audio.notch * 2.5);

  // color = 1.0 - color;
  color = color.grb;

  return color;
}

vec3 addicted_29_02(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos;
  vec3 color = vec3(1.0);

  float mul = 1.5;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  // float speed = 0.235;
  float speed = 0.035;

  // float inv = (2.0 * res.y) / res.x;
  float inv = uv.y / uv.x;

  // vec2 uv = fragCoord.xy / iResolution.xy;

  vec3 col = vec3(uv, 0.5 + 0.5 * sin(time));

  vec3 texcol;

  float x = (center.x-uv.x);
  float y = (center.y-uv.y) *inv;

  float r = 1.0;
  r = -sqrt(x * x + y * y);
  // r *= -(x * x - y * y);
  float z = 0.0 + 1.5 * sin( (r + time * speed) / 0.013 );

  texcol.x = z;
  texcol.y = z;
  texcol.z = z;

  // color.r *= abs(audio.bandpass) * 1.2;
  // color.b *= abs(audio.notch) * 2.0;

  color =  color - texcol;
  color.r *= abs(audio.notch);
  color.b *= abs(audio.lowpass) * 1.2;
  color.g *= abs(audio.highpass) * 3.5;
  // color = color.bgr;
  // color = color.grb;
  return color;
}

// 19:25 
vec3 addicted_29(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 0.8;
  audio.highpass  *= 0.8;
  audio.bandpass  *= 0.8;
  audio.notch     *= 0.8;

  // pos *= (sin(time * 0.05) * 10.0);
  pos *= 2.0;
  pos.x += 1.55;
  pos = rotate2d(sin(-pos.y) * 3.14 / 5.0) * sin(pos);
  float t = 0.6;
  vec2 pos_02 = pos;
  // uncomment at 20:30
  // pos_02.y += sin(time * 0.2);
  vec3 color_0 = addicted_29_02(pos_02, u_at, audio, u_resolution);
  vec3 color_1 = addicted_29_12(pos.yx, u_at, audio, u_resolution);
  color = mix(color_0, color_1, t);

  // color = color.gbr;
  color = color.brg;
  return color;
}
#endif

