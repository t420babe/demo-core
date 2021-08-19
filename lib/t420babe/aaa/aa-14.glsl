#ifndef T4B_AA_14
#define T4B_AA_14

#ifndef T4B_AA_RB_POS
#include "lib/t420babe/aa/aa-rb-position.glsl"
#endif

#ifndef T4B_AA_00
#include "lib/t420babe/aa/aa-00.glsl"
#endif

// Rainbow scales
vec3 aa_14_1(vec3 p3, float time, vec2 u_res, peakamp audio) {
  vec2 pos = p3.xy;
  pos = aa_rb_pos(pos, u_res, time);
  pos.y -= 0.5;
  vec3 color = aa_00_1(p3, time, audio);
  color =  vec3(color.x * pos.y, color.x, color.x);
  return vec3(color.x * pos.y, color.x, color.x);
}

void aa_14(vec3 p3, float time, vec2 u_res, peakamp audio) {
  vec3 color = aa_14_1(p3, time, u_res, audio);
  gl_FragColor = vec4(color, 1.0);
}
#endif
