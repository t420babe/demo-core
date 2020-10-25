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

#ifndef T420BABE_CATERPILLAR
#include "./lib/t420babe/wood-bb/caterpillar.glsl"
#endif

#ifndef T420BABE_GAMMA_ALLIG
#include "./lib/t420babe/gamma-allig.glsl"
#endif

#ifndef T420BABE_WOOD_BROTHER_LOUIE_3
#include "./lib/t420babe/wood-bb/wood-brother-louie-3.glsl"
#endif

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);
  //
  // //   vec3 tri_color = vec3(1.0);
  // //   tri_color *= sharp(triangle_web_1(pos, audio, u_time));
  // //
  // //   // purple_circle_oh_yes_he_is_mio(pos, u_time, audio, color);
  // //   color.r += 1.5;
  // //   orange_circle_bright_purple_bg_0(pos, u_time, audio, color);
  // //    color.r *= tri_color.b;
  // // // purple_circle_oh_yes_he_is_mio(pos, u_time, audio, color);
  //
  // vec3 purp_circle =  vec3(0.0);
  // purple_circle_oh_yes_he_is_mio(pos, u_time, audio, purp_circle);
  //
  // gamma_allig(pos, u_time, audio, purp_circle);
  //
  // color *= purp_circle;
	caterpillar(pos, u_time, audio, color);
  // wbl3_wood(pos, u_time, audio, color);
  gl_FragColor = vec4( color , 1.0);
}


