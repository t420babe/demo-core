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

// #ifndef T420BABE_MISX_05
// #include "./lib/t420babe/misc/misx-05.glsl"
// #endif
//
// #ifndef T420BABE_MISX_07
// #include "./lib/t420babe/misc/misx-07.glsl"
// #endif
//
// #ifndef T420BABE_MISX_16
// #include "./lib/t420babe/misc/misx-16.glsl"
// #endif
//
// #ifndef T420BABE_MISX_26
// #include "./lib/t420babe/misc/misx-26.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_01
// #include "./lib/t420babe/in-search-of/in-search-of-01.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_03
// #include "./lib/t420babe/in-search-of/in-search-of-03.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_04
// #include "./lib/t420babe/in-search-of/in-search-of-04.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_05
// #include "./lib/t420babe/in-search-of/in-search-of-05.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_06
// #include "./lib/t420babe/in-search-of/in-search-of-06.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_07
// #include "./lib/t420babe/in-search-of/in-search-of-07.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_08
// #include "./lib/t420babe/in-search-of/in-search-of-08.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_09
// #include "./lib/t420babe/in-search-of/in-search-of-09.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_10
// #include "./lib/t420babe/in-search-of/in-search-of-10.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_11
// #include "./lib/t420babe/in-search-of/in-search-of-11.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_12
// #include "./lib/t420babe/in-search-of/in-search-of-12.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_13
// #include "./lib/t420babe/in-search-of/in-search-of-13.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_14
// #include "./lib/t420babe/in-search-of/in-search-of-14.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_15
// #include "./lib/t420babe/in-search-of/in-search-of-15.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_16
// #include "./lib/t420babe/in-search-of/in-search-of-16.glsl"
// #endif
//
// #ifndef T420BABE_IN_SEARCH_OF_17
// #include "./lib/t420babe/in-search-of/iso-17.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_01
// #include "./lib/t420babe/nye2021/nye-2021-01.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_02
// #include "./lib/t420babe/nye2021/nye-2021-02.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_03
// #include "./lib/t420babe/nye2021/nye-2021-03.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_04
// #include "./lib/t420babe/nye2021/nye-2021-04.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_05
// #include "./lib/t420babe/nye2021/nye-2021-05.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_06
// #include "./lib/t420babe/nye2021/nye-2021-06.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_07
// #include "./lib/t420babe/nye2021/nye-2021-07.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_08
// #include "./lib/t420babe/nye2021/nye-2021-08.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_09
// #include "./lib/t420babe/nye2021/nye-2021-09.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_10
// #include "./lib/t420babe/nye2021/nye-2021-10.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_11
// #include "./lib/t420babe/nye2021/nye-2021-11.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_12
// #include "./lib/t420babe/nye2021/nye-2021-12.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_13
// #include "./lib/t420babe/nye2021/nye-2021-13.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_14
// #include "./lib/t420babe/nye2021/nye-2021-14.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_16
// #include "./lib/t420babe/nye2021/nye-2021-16.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_17
// #include "./lib/t420babe/nye2021/nye-2021-17.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_18
// #include "./lib/t420babe/nye2021/nye-2021-18.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_19
// #include "./lib/t420babe/nye2021/nye-2021-19.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_20
// #include "./lib/t420babe/nye2021/nye-2021-20.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_22
// #include "./lib/t420babe/nye2021/nye-2021-22.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_24
// #include "./lib/t420babe/nye2021/nye-2021-24.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_25
// #include "./lib/t420babe/nye2021/nye-2021-25.glsl"
// #endif
//
// #ifndef T420BABE_NYE_2021_26
// #include "./lib/t420babe/nye2021/nye-2021-26.glsl"
// #endif
//
// #ifndef T420BABE_DAY_0_00
// #include "./lib/t420babe/day-0/day-0-00.glsl"
// #endif
//
// #ifndef T420BABE_FEB_00
// #include "./lib/t420babe/feb/feb-00.glsl"
// #endif
//
// #ifndef T420BABE_FEB_HOSH
// #include "./lib/t420babe/feb/feb-hosh.glsl"
// #endif

// #ifndef T420BABE_FEB_MIXING
// #include "./lib/t420babe/feb/feb-mixing.glsl"
// #endif
//
// #ifndef T420BABE_LIGHTS_00
// #include "./lib/t420babe/lights/lights-00.glsl"
// #endif
//
// #ifndef T420BABE_LIGHTS_15
// #include "./lib/t420babe/lights/lights-15.glsl"
// #endif
//
// #ifndef T420BABE_LIGHTS_16
// #include "./lib/t420babe/lights/lights-16.glsl"
// #endif

#ifndef T420BABE_ADDICTED
#include "./lib/t420babe/addicted/addicted.glsl"
#endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec2 uv = gl_FragCoord.xy / u_resolution.xy;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);
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
  color = addicted(pos.yx, u_at, audio, u_resolution);

















  // color = addicted_16(pos, u_at, audio, u_resolution);

  // color_0 = addicted_05(pos, u_at, audio, u_resolution);
  // color_1 = addicted_15(pos.yx, u_at, audio, u_resolution);
  // color = mix(color_0, color_1, t);
  //
  // color_0 = addicted_15(pos, u_at, audio, u_resolution);
  // color_1 = addicted_15(pos.yx, u_at, audio, u_resolution);
  // color = mix(color_0, color_1, t);

  // color = addicted_15(pos, u_at, audio, u_resolution);


  // color_0 = addicted_10(pos, u_at, audio, u_resolution);
  // color_1 = addicted_05(pos, u_at, audio, u_resolution);
  // color = mix(color_1, color_0, t);
	gl_FragColor = vec4(color, 1.0);
}

