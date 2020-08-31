#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_COMMON
#include "./lib/common/common.glsl"
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.4, 0.23, 0.8);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // x_box(pos, u_time, audio, color);
  red_x_max(pos, u_time, audio, color);
  // pink_purple_x_max_oval(pos, u_time, audio, color);

  gl_FragColor = vec4(color, 1.0);
}

// autocmd BufWritePost * execute '!git add % && git commit -m %'
