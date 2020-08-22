#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#ifndef SOFT_RETRO_STEP
#include "lib/t420babe/soft-retro-step.glsl"
#endif

void main() {
  /* BEGIN TESTS */

  // Test 0: soft_retro_step(vec4 frag_coord, vec2 u_r)
  vec3 color = soft_retro_step(gl_FragCoord, u_resolution);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

