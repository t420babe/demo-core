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

/* COMMON_RANDOM BEGIN */
#ifndef COMMON_RANDOM
float random (in vec2 pos) {
    return fract( sin( dot( pos, vec2(12.9898, 78.233) ) ) * 43758.5453123);
}
#endif
/* COMMON_RANDOM END */

/* COMMON_NOISE BEGIN */
#ifndef COMMON_NOISE
float noise(vec2 pos) {
  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f * f * (3.0 - 2.0 * f);
  return mix(
      mix( random( i + vec2(0.0, 0.0) ), random( i + vec2(1.0, 0.0) ), u.x),
      mix( random( i + vec2(0.0, 1.0) ), random( i + vec2(1.0, 1.0) ), u.x),
      u.y);
}
#endif
/* COMMON_NOISE END */

/* T420BABE_GEO_GLOSS_0 BEGIN */
#ifndef T420BABE_GEO_GLOSS_1
float shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass);
  float theta = pos.y  * pos.x + audio.notch;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  m += noise( pos + u_time * 0.1) * 0.5;
  f += sin(theta * 50.0) * noise(pos + u_time * 1.0) * 0.1;
  f1 += (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;

  return 1.0 - smoothstep(f, f + 0.007, r) / fwidth(f1);
}

float shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return shape(pos, radius, u_time, audio) - shape(pos, radius - width, u_time, audio);
}

void gloss_1(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  color.r += audio.lowpass * 2.0;
  color *= shape_border(pos, 1.0, 0.10, u_time, audio);
  color.g *= audio.lowpass * 2.0;
}
#endif
/* T420BABE_GEO_GLOSS_0 END */

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
	vec3 color = vec3(1.0);
	gloss_1(pos, u_time, audio, color);

  gl_FragColor = vec4( color , 1.0);
}
