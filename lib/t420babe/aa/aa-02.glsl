#ifndef T4B_AA_02
#define T4B_AA_02

#ifndef T4B_AA_00
#include "./lib/t420babe/aa/aa-00.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_FUNCTIONS
#include "./lib/common/math-functions.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

vec3 aa_02_0(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  float f = ONE_MINUS_ABS_POW(pos.x, 1.0);
  float pct = fract(plot(pos, f, 2.1, 1.1)) * time * 5.0;

  vec3 color = vec3(pct);
  color =  vec3(1.0, color.y, color.x);
  color *= aa_00_1(p3, pct, audio);

  return fract(color);
}
void aa_02(vec3 p3, float time, peakamp audio) {
  vec3 color = aa_02_0(p3, time, audio);
  gl_FragColor = vec4(color, 1.0);
}

#endif
