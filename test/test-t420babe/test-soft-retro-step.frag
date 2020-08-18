#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_ave;
uniform float full_max;

#ifndef SOFT_RETRO_STEP
#include "../../lib/t420babe/soft-retro-step.glsl"
#endif

void main() {
  vec3 color = soft_retro_step(gl_FragCoord, u_resolution, full_ave);

  gl_FragColor = vec4(color, 1.0);
}
