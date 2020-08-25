#ifndef SOFT_RETRO_STEP
#define SOFT_RETRO_STEP

#ifndef FNC_AASTEP
#include "../pixel-spirit-deck/aastep.glsl"
#endif

vec3 soft_retro_step(vec2 pos) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  float f = aastep(pos.x, 0.5);
  float x = 0.1;
  float w = 0.5;
  float s = step(f, x + w * 0.5) - step(f, x - w * 0.5);
  vec3 color = vec3(s, pos.x, pos.y);
  return color;
}

#endif
