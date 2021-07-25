#ifndef T4B_AA_15
#define T4B_AA_15

#ifndef PXL_AASTEP
#include "./lib/pxl/aastep-sdf.glsl"
#endif

// Soft retro step

vec3 aa_15_1(vec3 p3) {
  vec2 pos = p3.xy;
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  float f = aastep(pos.x, 0.5);
  float x = 0.1;
  float w = 0.5;
  float s = step(f, x + w * 0.5) - step(f, x - w * 0.5);
  vec3 color = vec3(s, pos.x, pos.y);
  return color;
}

void aa_15(vec3 p3) {
  vec3 color = aa_15_1(p3);
  gl_FragColor = vec4(color, 1.0);
}
#endif
