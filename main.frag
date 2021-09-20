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

// #ifndef T4B_ABD_02
// #include "lib/t420babe/abd/abd-02.glsl"
// #endif

// #ifndef CELLULAR_NOISE_2_X_2_X_2
// #include "lib/cellular-noise/cellular-2x2x2.glsl"
// #endif

void main(void) {
  // peakamp audio = u_audio;
  // float audio_mul = 1.0;
  // audio.notch *= audio_mul;
  // audio.bandpass *= audio_mul;
  // audio.highpass *= audio_mul;
  // audio.lowpass *= audio_mul;
  // // 82
  // float time = t * 1.0 + 00.0;
  // abd_02(p3, t, u_audio);
  // gl_FragColor = vec4(2.0 * audio.notch, 0.3, 0.2, 1.0);
  gl_FragColor = vec4(sin(t), 0.4, 0.8, 1.0);
  // vec2 F = cellular2x2x2(p3.xyz);
  // float n = smoothstep(0.4, 0.5, F.x);
  // gl_FragColor = vec4(n, n, n, 1.0);
}
