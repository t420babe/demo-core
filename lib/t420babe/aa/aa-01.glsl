#ifndef T4B_AA_01
#define T4B_AA_01

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

vec3 aa_01_1(vec3 p3, float time) {
  vec2 pos = p3.xy;
  // float move_it = tan(1.14 + time);
  float move_it = 0.0;
  pos.y += move_it;
  float f = ONE_MINUS_ABS_POW(pos.y, 5.5);
  float pct = fract(plot(pos, f, 2.1, 1.1)) * time * 5.0;

  vec3 color = vec3(pct);
  color =  vec3(color.y + 0.3, 0.1, color.x);
  color *= aa_00_1(p3, pct);

  color = fract(color);
  return color;
}

void aa_01(vec3 p3, float time) {
  vec3 color = aa_01_1(p3, time);
  gl_FragColor = vec4(color, 1.0);
}
#endif
