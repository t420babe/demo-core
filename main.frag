#ifdef GL_ES
precision highp float;
#endif

uniform sampler2D u_tex0;
uniform sampler2D u_tex1;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef T420BABE_DAY_0_07
#include "./lib/t420babe/day-0/day-0-07.glsl"
#endif


void main(void) {
	// vec2 st = gl_FragCoord.xy/u_resolution.xy;
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec2 st = pos;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  audio.lowpass *= 1.5;
  audio.highpass *= 2.5;
  audio.bandpass *= 1.0;
  audio.notch *= 1.0;
  vec3 color = day_0_07(pos, u_time, audio);

	gl_FragColor = vec4(color, 1.0);
}

