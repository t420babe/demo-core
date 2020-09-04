#ifdef GL_ES
precision mediump float;
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // doppler_blue_web(pos, u_time, audio, color);
  // sayin_sayin_deep_blue(pos, u_time, audio, color);
  // sayin_sayin_red(pos, u_time, audio, color);
  // sayin_sayin_break(pos, u_time, audio, color);
  // sayin_sayin_single_red_fracture(pos, u_time, audio, color);
	// sayin_sayin_red_fracture(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture(pos, u_time, audio, color);
  // sayin_sayin_dancing_blue_clock(pos, u_time, audio, color);
	// sayin_sayin_blue_clock(pos, u_time, audio, color);
	// sayin_sayin_cyan_black_clock(pos, u_time, audio, color);
	// sayin_sayin_blue_clock_og(pos, u_time, audio, color);
	// sayin_sayin_blue_wiggly_clock(pos, u_time, audio, color);
  // sayin_sayin_cyan_schnoodle(pos, u_time, audio, color);
  // sayin_sayin_red_line_zoom(pos, u_time, audio, color);
  // sayin_sayin_red_kal(pos, u_time, audio, color);
  // sayin_sayin_red_kal_2(pos, u_time, audio, color);
  // sayin_sayin_red_line_zoom(pos, u_time, audio, color);
  // sayin_sayin_retro_vibez_0(pos, u_time, audio, color);
  // sayin_sayin_retro_vibez_1(pos, u_time, audio, color);
  // sayin_sayin_sliding(pos, u_time, audio, color);
  // sayin_sayin_sliding_in(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_cyan_square(pos, u_time, audio, color);
  // sayin_sayin_digital_black_hole(pos, u_time, audio, color);
  // doppler_rainbow_heart(pos, u_time, audio, color);
  // doppler_sofias_rainbow(pos, u_time, audio, color);
  doppler_blue_web(pos, u_time, audio, color);
	// hypnotized_by_the_light(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
