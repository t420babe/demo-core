#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

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

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

// #ifndef T4B_TTT_28
// #include "lib/t420babe/talk-talk-talk/ttt-28.glsl"
// #endif
//
// #ifndef T4B_TTT_28
// #include "lib/t420babe/talk-talk-talk/ttt-28.glsl"
// #endif
//
// #ifndef T420BABE_CHOICE_49
// #include "lib/t420babe/choice/choice-49.glsl"
// #endif

#ifndef T420BABE_ELECTRONS_28
#include "./lib/t420babe/electrons/electrons-28.glsl"
#endif


void main(void) {
	vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  float time = u_at;

  vec3 color = vec3(1.0);
  // color = ttt_28(pos, time, audio);
  // color = choice_49(pos, time, audio);

  color = ele_28(pos, time, audio, u_resolution);
  // color *= audio.notch * 200.0;

	gl_FragColor = vec4(color, 1.0);
}

