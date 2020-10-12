// Techno Prank - Dubdogz
#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef CLOUDS
#include "./lib/bos/clouds.glsl"
#endif

#ifndef T420BABE_SHARP_HEART
#include "./lib/t420babe/doppler-heart.glsl"
#endif


uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif

#ifndef PXL_RAYS
#include "./lib/pxl/rays-sdf.glsl"
#endif

vec3 my_mix_0(peakamp audio) {
  vec3 c1 = vec3(0.760704, 0.94902, 0.0);
  vec3 c0 = vec3(0.94902 ,0.0, 0.760704);
  float f = abs(audio.bandpass);
  vec3 color = (1.0 - f) * c0 + f * c1;
  return color;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);
  // dyka(pos, u_time, audio, color);
  // alligator(pos, u_time, audio, color);
  // couch26(pos, u_time, audio, color);
  // couch17(pos, u_time, audio, color);
  // couch74(pos, u_time, audio, color);


  // clouds(pos, u_time, audio, color);
  //  vec3 purp_circle =  vec3(0.0);
  //  vec2 rayz_position = pos * 9.0 * audio.notch;
  //
  //  float rayz = rays_audio(rayz_position, 60, audio);
  //  color *= rayz;
  //  purple_circle_oh_yes_he_is_mio(pos, u_time, audio, purp_circle);
  //  color += purp_circle;

  // im_a_real_cunt_in_spring(pos, u_time, audio, color);
  say_nothing_next(pos, u_time, audio, color);

  // clouds(pos, u_time, audio, color);
  // vec3 heart_color = vec3(1.0);
  // doppler_sharp_heart_0(pos, u_time, audio, heart_color);
  // color += 0.2;
  // color -= heart_color;

  gl_FragColor = vec4(color, 1.0);
}
