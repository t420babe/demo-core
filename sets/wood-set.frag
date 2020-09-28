/* target qmetro: 20 ms but can set it and forget it at 30 ms */
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

void wood_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 15.0);

  if (my_time < S(1.0, seconds)) {
    wood_bb_hexagon_0(pos, u_time, audio, color);
  } else if(my_time < S(2.0, seconds)) {
    wood_bb_red_tan_noise(pos, u_time, audio, color);
  } else if(my_time < S(3.0, seconds)) {
    wood_bb_red_noise(pos, u_time, audio, color);
  } else if(my_time < S(4.0, seconds)) {
    wbl_wood(pos, u_time, audio, color);
  } else if(my_time < S(5.0, seconds)) {
    wbl1_wood(pos, u_time, audio, color);
  } else if(my_time < S(6.0, seconds)) {
    wbl2_wood(pos, u_time, audio, color);
  } else if(my_time < S(7.0, seconds)) {
    caterpillar(pos, u_time, audio, color);
  } else if(my_time < S(8.0, seconds)) {
    wbl5_wood(pos, u_time, audio, color);
  } else if(my_time < S(9.0, seconds)) {
    wbl5b_wood(pos, u_time, audio, color);
  } else if(my_time < S(10.0, seconds)) {
    wbl5c_wood(pos, u_time, audio, color);
  } else if(my_time < S(11.0, seconds)) {
    wbl5d_wood(pos, u_time, audio, color);
  } else if(my_time < S(12.0, seconds)) {
    wbl6_wood(pos, u_time, audio, color);
  } else if(my_time < S(13.0, seconds)) {
    wbl7_wood(pos, u_time, audio, color);
  } else if(my_time < S(14.0, seconds)) {
    wbl8_wood(pos, u_time, audio, color);
  } else {
    wbl8_wood(pos, u_time, audio, color);
  }
}

void wood_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  wood_bb_hexagon_0(pos, u_time, audio, color);    // good
  // wood_bb_red_tan_noise(pos, u_time, audio, color);
  // wood_bb_red_noise(pos, u_time, audio, color);
  // wbl_wood(pos, u_time, audio, color);  // H
  // wbl1_wood(pos, u_time, audio, color);  // H
  // wbl2_wood(pos, u_time, audio, color);
  // caterpillar(pos, u_time, audio, color);   // H
  // wbl5_wood(pos, u_time, audio, color);   // Clarity of Love - Pirupa, Pigi
  // wbl5b_wood(pos, u_time, audio, color);  // HHHH Fun
  // wbl5c_wood(pos, u_time, audio, color); // HH
  // wbl5d_wood(pos, u_time, audio, color); // HHHH
  // wbl6_wood(pos, u_time, audio, color);
  // wbl7_wood(pos, u_time, audio, color);  // H Heaven can wait
  // wbl8_wood(pos, u_time, audio, color); /// HHH - Brother Louie
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  float seconds = 60.0;
  wood_auto(pos, u_time, audio, color, seconds);

  // wood_manual(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
