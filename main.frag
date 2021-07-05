#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

uniform vec2 u_resolution;

uniform float t;
uniform peakamp u_audio;
varying vec3 p3;
uniform sampler2D u_fb;
uniform sampler2D u_freq_fast;
uniform sampler2D u_freq_med;
uniform sampler2D u_freq_slow;

#ifndef COMMON_S4Y
#include "lib/common/s4y.glsl"
#endif

#ifndef T4B_TTT_38
#include "lib/t420babe/talk-talk-talk/ttt-38.glsl"
#endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  audio = u_audio;
  float time = t;
  // time += t2s(0, 5, 0);
  // time += 388.0;
  // time *= 4.0;
  // 11
  // ttt_38(p3, time, audio);
  // left off @20
  ttt_38(p3, time, audio);

  // vec3 color = vec3(audio.notch, audio.bandpass, audio.highpass) * 2.0;
  // gl_FragColor = vec4(color, 1.0);
}
