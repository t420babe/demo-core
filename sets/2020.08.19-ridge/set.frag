#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

uniform float song_id;

#ifndef PULSE_X
#include "../../lib/t420babe/pulse-x.glsl"
#endif

#ifndef T420BABE_WOOD_BB
#include "../../lib/t420babe/wood-bb.glsl"
#endif

#ifndef T420BABE_RIDGE
#include "../../lib/t420babe/ridge.glsl"
#endif

void main() {
  // vec3 color = pink_red_x(gl_FragCoord, u_resolution, u_time, full_ave);
  // vec3 color = wood_bb(gl_FragCoord, u_resolution, u_time, full_ave, full_max);
  vec3 color = ridge_main(gl_FragCoord, u_resolution, u_time, full_ave, full_max);

  gl_FragColor = vec4(color, 1.0);
}
