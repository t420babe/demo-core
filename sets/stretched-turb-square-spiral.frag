#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

uniform sampler2D u_tex0;
uniform sampler2D u_tex1;

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef T420BABE_SHARP_HEART
#include "./lib/t420babe/doppler-heart.glsl"
#endif

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
	vec3 color = vec3(1.0);
	say_nothing_next(pos, u_time, audio, color);

  gl_FragColor = vec4( color , 1.0);
}
