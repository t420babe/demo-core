#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

#ifndef COMMON_COMMON
#include "lib/common/common.glsl"
#endif

void main() {
  vec3 color = vec3(1.0);
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

  gl_FragColor = vec4(color, 1.0);
}

