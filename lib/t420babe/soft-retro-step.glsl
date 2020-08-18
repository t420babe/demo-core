#ifndef SOFT_RETRO_STEP
#define SOFT_RETRO_STEP

#ifndef FNC_AASTEP
#include "../pixel-spirit-deck/aastep.glsl"
#endif

vec3 retro_step(vec2 pos, vec2 u_r) {
  float f = aastep(pos.x, 0.5);
  float x = 0.1;
  float w = 0.5;
  float s = step(f, x + w * 0.5) - step(f, x - w * 0.5);
  vec3 color = vec3(s, pos.x, pos.y);
  return color;
}

vec3 soft_retro_step(vec4 frag_coord, vec2 u_r, float full_ave) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  vec3 color = vec3(1.0);

  if (full_ave > 2.5) {
    color = retro_step(pos, u_r) * full_ave;
  } else {
    color = retro_step(pos, u_r);
  }
  return color;
}

#endif
