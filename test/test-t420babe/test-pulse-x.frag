#ifdef GL_ES
precision mediump float;
#endif

#ifndef PULSE_X
#include "lib/t420babe/pulse-x.glsl"
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;


void main() {
  // Test pulse x. Requires audio in
  vec3 color = pink_red_x(gl_FragCoord, u_resolution, u_time, full_ave);

  gl_FragColor = vec4(color, 1.0);
}
