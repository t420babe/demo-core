#ifdef GL_ES
precision mediump float;
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;


uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

  vec3 color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos * u_notch);
  color = vec3(pct * color + color * pct2);
  // color = vec3(pct2 * color + color * vec3(0.5));

  gl_FragColor = vec4(color, 1.0);
}
