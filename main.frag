#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON
#include "./lib/common/common.glsl"
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
  vec3 color = vec3(0.2, 0.243, 0.0234);

  // float pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  float pct = sharp(circle_1(pos * 1.1, u_notch));
  color = vec3(pct * color + pct + color.gbr);
  // int num_vesicas = 4.0;
  // for (int i = 0; i < num_vesicas; i++) {
  //   pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  //   color = vec3(pct * color + pct * color);
  // }

  gl_FragColor = vec4(color, 1.0);
}

  // autocmd BufWritePost * execute '!git add % && git commit -m %'
