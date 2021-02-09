#ifndef T420BABE_ADDICTED_01
#define T420BABE_ADDICTED_01

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

vec3 addicted_01(vec2 pos, float u_time, peakamp audio, vec2 res) {
  vec2 uv = pos;
  vec3 color = vec3(1.0);

  float mul = 5.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.035;

  float invAr = (2.0 * res.y) / res.x;

  vec3 col = vec4(uv, 0.5 + 0.5 * sin(u_time), 1.0).xyz;

  vec3 texcol;

  float x = (center.x - uv.x) * audio.notch;
  float y = (center.y - uv.y) * invAr * audio.notch;

  //float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
  float r = -(x*x + y*y);
  float z = 1.0 + 1.0 * sin((r+u_time*speed)/0.013);

  texcol.x = sin(x * u_time) * y;
  texcol.y = z;
  texcol.z = abs(sin(y * u_time));
  texcol = 0.5 - texcol;

  color /= texcol;
  color = color.bgr;

  return color;
}
#endif
