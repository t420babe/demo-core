// #fav5 #feb
#ifndef T420BABE_AA_32
#define T420BABE_AA_32

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


#ifndef T420BABE_AA_31
#include "./lib/t420babe/aa/aa-31.glsl"
#endif

vec3 aa_32_29_12(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos.yx;
  uv *= 15.0;
  vec3 color = vec3(1.0);

  float mul = 5.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 1.0;
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

  // color = 0.5 - color;
  color = color.grb;

  return color;
}

vec3 aa_32_29_02(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos;
  vec3 color = vec3(1.0);

  float mul = 5.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.235;

  // float inv = (2.0 * res.y) / res.x;
  float inv = uv.y / uv.x;

  // vec2 uv = fragCoord.xy / iResolution.xy;

  vec3 col = vec4(uv,0.5+0.5*sin(time),1.0).xyz;

  vec3 texcol;

  float x = (center.x-uv.x);
  float y = (center.y-uv.y) *inv;

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
  // color = 1.0 - color;
  // color = color.bgr;
  // color = color.grb;
  return color;
}

vec3 aa_32_29(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);

  float t = 0.2;
  vec3 color_0 = aa_02(pos, u_at, audio, u_resolution);
  vec3 color_1 = aa_12(pos.yx, u_at, audio, u_resolution);
  color = mix(color_0, color_1, t);

  // color = color.gbr;
  color = color.brg;
  return color;
}


vec3 aa_32(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);

  float t = wrap_time(time * 0.1, 1.0);

  // x = r cos(t)    y = r sin(t)
  vec3 color_0 = aa_32_29(pos, u_at * 1.0, audio, u_resolution);
  pos = rotate2d(sin(u_time * 0.1) * 3.14 / 5.0) * pos;
  pos.x = 1.0 * cos(pos.x);
  pos.y = 1.0 * sin(pos.y);
  vec3 color_1 = aa_31(pos, u_at * 1.0, audio, u_resolution);
  color = mix(color_1, color_0, t);
  return color;
}
#endif

