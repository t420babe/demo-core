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

  pos.x += 0.40;
  pos.y += 0.50;
  vec3 color = vec3(1.1, 0.1234, 0.34);
  // float pct = aastep(pos.y, -pos.y);
  float pct = cross_sdf(pos, 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * u_highpass * 2.5;

  // float rect = cross_sdf(pos, 0.4);
  // color = vec3(pct * color + color * rect);
  // color = vec3(pct2 * color + color * vec3(0.5));

  gl_FragColor = vec4(color, 1.0);
}

  // autocmd BufWritePost * execute '!git add % && git commit -m %'
