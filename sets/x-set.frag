/* target qmetro: 60 ms but can set it and forget it at 45 ms */
#ifdef GL_ES
precision mediump float;
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef UNIFORMS
#define UNIFORMS
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#endif

#ifndef COMMON_COMMON
#include "./common/00-common.glsl"
#endif

#ifndef PXL
#include "./pxl/00-pxl.glsl"
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif

#ifndef S
#define S(multiplier, seconds) multiplier * seconds
#endif

void x_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 5.0);

  if (my_time < S(1.0, seconds)) {
    x_box(pos, u_time, audio, color);
  } else if(my_time < S(2.0, seconds)) {
    pink_purple_x_max_oval(pos, u_time, audio, color);
  } else if(my_time < S(3.0, seconds)) {
    pink_purple_x_max(pos, u_time, audio, color);
  } else if(my_time < S(3.0, seconds)) {
    pink_purple_x_max_0(pos, u_time, audio, color);
  } else if(my_time < S(4.0, seconds)) {
    red_x_max(pos, u_time, audio, color);
  } else {
    pink_purple_x_max(pos, u_time, audio, color);
  }
}

void x_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  x_box(pos, u_time, audio, color);
  // pink_purple_x_max_oval(pos, u_time, audio, color);
  // pink_purple_x_max(pos, u_time, audio, color);
  // pink_purple_x_max_0(pos, u_time, audio, color);
  // pink_purple_x_max_1(pos, u_time, audio, color); // Sosa
  // red_x_max(pos, u_time, audio, color);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  float seconds = 5.0;
  x_auto(pos, u_time, audio, color, seconds);

  // x_manual(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
