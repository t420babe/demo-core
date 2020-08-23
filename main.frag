#ifdef GL_ES
precision mediump float;
#endif

#ifndef ALBERS
#include "lib/albers/albers.glsl"
#endif

uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

  vec3 color = vec3(0.2);
  // color = albers_iv_1(pos);

  color = albers_iv_3(pos);

  gl_FragColor = vec4(color, 1.0);
}


