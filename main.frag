#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;
uniform float u_at;

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

// #ifndef COMMON_MATH_CONSTANTS
// #include "./lib/common/math-constants.glsl"
// #endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_TRANS
#include "./lib/common/trans.glsl"
#endif

// #ifndef COMMON_PLOT
// #include "./lib/common/plot.glsl"
// #endif

#ifndef T420BABE_CHOICE_32
#include "./lib/t420babe/choice/choice-32.glsl"
#endif

// #ifndef T420BABE_COMPLETE_20
// #include "./lib/t420babe/complete/complete-20.glsl"
// #endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec2 uv = gl_FragCoord.xy / u_resolution.xy;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec2 frag_coord = gl_FragCoord.xy;

  // vec3 color = complete_20(pos, u_at, audio);
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t;
  float start = 20.0;
  float end = 20.0;

  // t = trans(u_at, start, end);
  // t = wrap_time(u_at * 1.0, 1.0);
  color_0 = choice_32(pos, u_at, audio);
  // color_1 = choice_20(pos.yx, u_at, audio);
  // color = mix(color_1, color_0, 1.00);
  color = color_0;
  gl_FragColor = vec4(color, 1.0);
}

