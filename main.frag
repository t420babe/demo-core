// check out phish visuals/lights, flaming lips, 9 inch nails, lcd sound system
// lights 02
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

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_TRANS
#include "./lib/common/trans.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef T420BABE_IN_SEARCH_OF_01
#include "./lib/t420babe/in-search-of/in-search-of-01.glsl"
#endif

#ifndef T420BABE_IN_SEARCH_OF_03
#include "./lib/t420babe/in-search-of/in-search-of-03.glsl"
#endif

#ifndef T420BABE_IN_SEARCH_OF_04
#include "./lib/t420babe/in-search-of/in-search-of-04.glsl"
#endif

#ifndef T420BABE_IN_SEARCH_OF_05
#include "./lib/t420babe/in-search-of/in-search-of-05.glsl"
#endif

#ifndef T420BABE_IN_SEARCH_OF_06
#include "./lib/t420babe/in-search-of/in-search-of-06.glsl"
#endif

#ifndef T420BABE_IN_SEARCH_OF_07
#include "./lib/t420babe/in-search-of/in-search-of-07.glsl"
#endif

#ifndef T420BABE_IN_SEARCH_OF_08
#include "./lib/t420babe/in-search-of/in-search-of-08.glsl"
#endif

#ifndef T420BABE_IN_SEARCH_OF_17
#include "./lib/t420babe/in-search-of/iso-17.glsl"
#endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  // color_0 = in_search_of_01(pos, u_at, audio);
  color_0 = iso_07(pos, u_at, audio);
  color_1 = iso_08(pos, u_at, audio);

  float start = 00.0;
  float end = 20.0;
  // color = mix(color_1, color_0, trans(u_at, start, end));

  color = color_1;

	gl_FragColor = vec4(color, 1.0);
}

