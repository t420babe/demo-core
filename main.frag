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

#ifndef T4B_TTT_03
#include "lib/t420babe/talk-talk-talk/ttt-03.glsl"
#endif

#ifndef T4B_TTT_21
#include "lib/t420babe/talk-talk-talk/ttt-21.glsl"
#endif

void main(void) {
	vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  float time = u_at;

  vec3 color = vec3(1.0);
  color = ttt_21(pos, time, audio);


	gl_FragColor = vec4(color, 1.0);
}

