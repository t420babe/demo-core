#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
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

#ifndef COMMON_RANDOM
#include "./lib/common/random.glsl"
#endif

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif

#ifndef PXL_TRIANGLE
#include "./lib/pxl/triangle-sdf.glsl"
#endif

#ifndef T420BABE_CATERPILLAR
#include "./lib/t420babe/wood-bb/caterpillar.glsl"
#endif

#ifndef T420BABE_COUCH_2
#include "./lib/t420babe/couch/couch-2.glsl"
#endif

#ifndef PXL_HEART
#include "./lib/pxl/heart-sdf.glsl"
#endif

#ifndef PXL_SPIRAL
#include "./lib/pxl/spiral-sdf.glsl"
#endif

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
	vec3 color = vec3(1.0);
  float heart = sharp(heart_web_0(pos, audio, u_time));

//   vec3 tri_color = vec3(1.0);
//   tri_color *= sharp(triangle_web_1(pos, audio, u_time));
//
//   // purple_circle_oh_yes_he_is_mio(pos, u_time, audio, color);
//   color.r += 1.5;
//   orange_circle_bright_purple_bg_0(pos, u_time, audio, color);
//   color.r *= tri_color.b;
// // purple_circle_oh_yes_he_is_mio(pos, u_time, audio, color);

  // caterpillar(pos, u_time, audio, color);
  couch2(pos, u_time, audio, color);
  color /= heart;
  color.r = abs(sin(u_time));
  gl_FragColor = vec4( color , 1.0);
}

