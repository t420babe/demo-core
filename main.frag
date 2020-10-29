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

#ifndef T420BABE_CASH
#ifndef PXL_HEXAGON
#include "./lib/pxl/hex-sdf.glsl"
#endif

#ifndef BOS_CLOUDS_HA
#include "./lib/bos/clouds-ha.glsl"
#endif

#ifndef BOS_2D_CNOISE_2X2X2_FUCK_WIT
#include "./lib/bos/2d-cnoise-2x2x2-fuck-wit.glsl"
#endif

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
	vec3 color = vec3(1.0);
  float n = cnoise_2d_2x2x2_fuck_wit(pos, u_time, audio);
  color = vec3(n * sin(u_time), n, n * audio.lowpass);
  gl_FragColor = vec4( color , 1.0);
}
