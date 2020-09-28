/* target qmetro: 20 ms */
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

void circle_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 5.0);

  if (my_time < S(1.0, seconds)) {
    purple_concentric(pos, u_time, audio, color);
  } else if(my_time < S(2.0, seconds)) {
    green_concentric(pos, u_time, audio, color);
  } else if(my_time < S(3.0, seconds)) {
    purple_circle(pos, u_time, audio, color);
  } else if(my_time < S(3.0, seconds)) {
    orange_circle_bright_purple_bg(pos, u_time, audio, color);
  } else {
    orange_circle_bright_purple_bg(pos, u_time, audio, color);
  }
}

// All The Ladies - Fat Boy Slim
void circle_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  purple_concentric(pos, u_time, audio, color);
  // green_concentric(pos, u_time, audio, color);
  // purple_circle(pos, u_time, audio, color);
  // orange_circle_bright_purple_bg(pos, u_time, audio, color);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // float seconds = 60.0;
  // circle_auto(pos, u_time, audio, color, seconds);

  circle_manual(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
