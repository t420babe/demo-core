#ifndef T4B_AA_11
#define T4B_AA_11

#ifndef T4B_AA_RB_POS
#include "lib/t420babe/aa/aa-rb-position.glsl"
#endif

#ifndef T4B_AA_07
#include "lib/t420babe/aa/aa-07.glsl"
#endif

// Rainbow scales
vec3 aa_11_1(vec3 p3, float time, vec2 u_res, peakamp audio) {
  vec2 pos = p3.xy;
  pos = aa_rb_pos(pos, u_res, time);
  pos.y -= 0.5;
  vec3 color = aa_07_1(p3, time, audio);
  return vec3(color.x * pos.y, color.x, color.x);
}

void aa_11(vec3 p3, float time, vec2 u_res, peakamp audio) {
  vec3 color = aa_11_1(p3, time, u_res, audio);
  gl_FragColor = vec4(color, 1.0);
}
#endif
