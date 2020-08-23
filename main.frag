#ifdef GL_ES
precision mediump float;
#endif

#ifndef ALBERS_IV_1
#include "lib/albers/iv-1.glsl"
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

  vec3 color = vec3(0.2);
  color = albers_iv_1(pos);

  gl_FragColor = vec4(color, 1.0);
}


