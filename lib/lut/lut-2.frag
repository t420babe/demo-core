#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef LUT_2
#include "./lib/lut/lut-2.glsl"
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

void main(){
	vec2 pos = gl_FragCoord.xy / u_resolution.xy;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  lut_2(pos, u_time, audio, u_tex0, u_tex1, color);

	gl_FragColor = vec4(color , 1.0);
}
