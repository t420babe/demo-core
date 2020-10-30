#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef T420BABE_MONSTERA_3
#include "./lib/t420babe/monstera/monstera-3.glsl"
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

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(0.0);

  monstera_3(pos, u_time, audio, color);
  gl_FragColor = vec4( color , 1.0);
}
