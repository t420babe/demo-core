#ifdef GL_ES
precision mediump float;
#endif

#ifndef T420BABE_PURPLE_CIRLCE
#include "./lib/t420babe/purple-circle.aa.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;


uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = purple_circle(pos, u_lowpass, u_highpass, u_bandpass, u_notch);
  gl_FragColor = vec4(color, 1.0);
}

// autocmd BufWritePost * execute '!git add % && git commit -m %'
