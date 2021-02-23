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

// #ifndef COMMON_WRAP_TIME
// #include "./lib/common/wrap-time.glsl"
// #endif

// #ifndef COMMON_MATH_CONSTANTS
// #include "./lib/common/math-constants.glsl"
// #endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

// #ifndef COMMON_TRANS
// #include "./lib/common/trans.glsl"
// #endif
//
// #ifndef COMMON_PLOT
// #include "./lib/common/plot.glsl"
// #endif

#ifndef T420BABE_CHOICE_16
#include "./lib/t420babe/choice/choice-16.glsl"
#endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec2 uv = gl_FragCoord.xy / u_resolution.xy;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec2 frag_coord = gl_FragCoord.xy;

  vec3 color = choice_16(pos, u_at, audio);



  // vec3 color_0 = vec3(1.0);
  // vec3 color_1 = vec3(1.0);
  //
  // float t;
  // float start = 00.0;
  // float end = 20.0;
  //
  // t = trans(u_at, start, end);
  // t = wrap_time(u_at * 0.1, 1.0);
  // color_0 = addicted_12(pos, u_at, audio, u_resolution);
  // color_1 = addicted_15(pos.yx, u_at, audio, u_resolution);
  // color = mix(color_0, color_1, t);
  gl_FragColor = vec4(color, 1.0);
}

