#ifndef T420BABE_ADDICTED_03
#define T420BABE_ADDICTED_03

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

void aa_03(vec3 p3, float u_time, peakamp audio, vec2 res) {
  vec2 uv = p3.yx;
  uv *= 2.0;
  vec3 color = vec3(1.0);

  float mul = 1.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.05;
  float invAr = (1.5 * res.y) / res.y;

  vec3 texcol;

  float x = (center.x - sin(uv.x));
  float y = (center.y - sin(uv.x * uv.y)) *invAr;

  //float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
  float r = -(x*x + y*y);
  float z = 0.0 + 0.5*sin((r+u_time*speed)/0.013);

  texcol.x = z;
  texcol.y = z;
  texcol.z = z;

  color *= texcol;
  color.r *= abs(audio.notch * 8.0);
  color.g *= abs(sin(u_time));

  gl_FragColor = vec4(color, 1.0);
}
#endif
