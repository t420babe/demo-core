#ifdef GL_ES
precision mediump float;
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef UNIFORMS
#define UNIFORMS
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#endif

#ifndef COMMON_COMMON
#include "./common/00-common.glsl"
#endif

#ifndef PXL
#include "./pxl/00-pxl.glsl"
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif

#ifndef S
#define S(multiplier, seconds) multiplier * seconds
#endif

/* Needs house house */
/* qmetro: can set it and forget it at 45 ms */


void sayin_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 23.0);

  if (my_time < S(1.0, seconds)) {
    // need audio in shape
    sayin_sayin_digital_black_hole(pos, u_time, audio, color);
  } else if(my_time < S(2.0, seconds)) {
    // need audio in shape
    sayin_sayin_sliding_in_cyan_square(pos, u_time, audio, color);
  } else if(my_time < S(3.0, seconds)) {
    // need audio in shape
    sayin_sayin_sliding_in_cyan_square_og(pos, u_time, audio, color);
  } else if(my_time < S(4.0, seconds)) {
    // improve colors
    sayin_sayin_sliding_in_0(pos, u_time, audio, color);
  } else if(my_time < S(5.0, seconds)) {
    // improve colors
    sayin_sayin_sliding_in_1(pos, u_time, audio, color);
  } else if(my_time < S(6.0, seconds)) {
    sayin_sayin_sliding_in_2(pos, u_time, audio, color);    // H
  } else if(my_time < S(7.0, seconds)) {
    sayin_sayin_deep_blue(pos, u_time, audio, color);
  } else if(my_time < S(8.0, seconds)) {
    sayin_sayin_red(pos, u_time, audio, color);
  } else if(my_time < S(9.0, seconds)) {
    sayin_sayin_red_fracture(pos, u_time, audio, color);
  } else if(my_time < S(10.0, seconds)) {
    sayin_sayin_blue_single_fracture_0(pos, u_time, audio, color);
  } else if(my_time < S(11.0, seconds)) {
    sayin_sayin_blue_single_fracture_1(pos, u_time, audio, color);   // H favorite color combo
  } else if(my_time < S(12.0, seconds)) {
    sayin_sayin_blue_single_fracture_2(pos, u_time, audio, color);   // H favorite color combo
  } else if(my_time < S(13.0, seconds)) {
    sayin_sayin_blue_clock_arrow_0(pos, u_time, audio, color);  // H, really cool, Techno Disco
  } else if(my_time < S(14.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  } else if(my_time < S(15.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_0(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  } else if(my_time < S(16.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_1(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  } else if(my_time < S(17.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_2(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  } else if(my_time < S(18.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_3(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  } else if(my_time < S(19.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_3b(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  } else if(my_time < S(20.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  } else {
    sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  }
}

void sayin_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  sayin_sayin_digital_black_hole(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_cyan_square(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_cyan_square_og(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_0(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_1(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_2(pos, u_time, audio, color);
  // sayin_sayin_deep_blue(pos, u_time, audio, color);
  // sayin_sayin_red(pos, u_time, audio, color);
  // sayin_sayin_red_fracture(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture_0(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture_1(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture_2(pos, u_time, audio, color);
  // sayin_sayin_blue_clock_arrow_0(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og_0(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og_1(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og_2(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og_3(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og_3b(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);


  float seconds = 60.0;
  sayin_auto(pos, u_time, audio, color, seconds);

  // sayin_manual(pos, u_time, audio, color);

  gl_FragColor = vec4(color, 1.0);
}
