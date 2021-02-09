#ifndef T420BABE_ADDICTED_06
#define T420BABE_ADDICTED_06

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


vec3 addicted_06(vec2 pos, float u_time, peakamp audio, vec2 res) {
  vec2 uv = pos.yx;
  uv *= 5.0;
  vec3 color = vec3(1.0);

  float mul = 3.0;
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
  color.b *= abs(audio.bandpass * 2.0);
  color.g *= abs(sin(u_time) * audio.lowpass * 2.0 + 0.1);
  color.r *= abs(audio.notch * 2.0);

  return color;
}
#endif

