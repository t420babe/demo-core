#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_COMMON
#include "./lib/common/common.glsl"
#endif

#ifndef T420BABE
#include "./lib/t420babe/audio-circle.aa.glsl"
#endif

#ifndef T420BABE_RIDGE
#include "./lib/t420babe/ridge.glsl"
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
  color = ridge_main(gl_FragCoord, u_resolution, u_time, u_lowpass, u_highpass * 100.0);

  // color = purple_circle(pos, u_time, audio);
  // color = orange_circle_bright_purple_bg(pos, u_time, audio);
  gl_FragColor = vec4(color, 1.0);
}

// autocmd BufWritePost * execute '!git add % && git commit -m %'
