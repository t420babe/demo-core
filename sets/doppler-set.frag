/* target qmetro: 20, 30 ok too */
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

void doppler_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 57.0);

  if (my_time < S(1.0, seconds)) {
    doppler_audio(pos, u_time, audio, color);
  } else if(my_time < S(2.0, seconds)) {
    doppler_blue_web(pos, u_time, audio, color);
  } else if(my_time < S(3.0, seconds)) {
    doppler_sharp_heart(pos, u_time, audio, color);
  } else if(my_time < S(4.0, seconds)) {
    doppler_rainbow_heart(pos, u_time, audio, color);
  } else if(my_time < S(5.0, seconds)) {
    doppler_sofias_rainbow(pos, u_time, audio, color);
  } else if(my_time < S(6.0, seconds)) {
    doppler_red_red_sun(pos, u_time, audio, color);
  } else if(my_time < S(7.0, seconds)) {
    doppler_green_rooster(pos, u_time, audio, color);
  } else if(my_time < S(8.0, seconds)) {
    doppler_sun_star_rooster(pos, u_time, audio, color);
  } else if(my_time < S(9.0, seconds)) {
    doppler_blue_cross_spinning(pos, u_time, audio, color);
  } else if(my_time < S(10.0, seconds)) {
    doppler_blue_cross(pos, u_time, audio, color);
  } else if(my_time < S(11.0, seconds)) {
    doppler_blue_step_cross_horizontal(pos, u_time, audio, color);
  } else if(my_time < S(12.0, seconds)) {
    doppler_blue_step_cross(pos, u_time, audio, color);
  } else if(my_time < S(13.0, seconds)) {
    doppler_cross_step_1(pos, u_time, audio, color);
  } else if(my_time < S(14.0, seconds)) {
    doppler_floating_ring_morph(pos, u_time, audio, color);
  } else if(my_time < S(15.0, seconds)) {
    doppler_floating_ring_morph_1(pos, u_time, audio, color);
  } else if(my_time < S(16.0, seconds)) {
    doppler_cross_step_2(pos, u_time, audio, color);
  } else if(my_time < S(17.0, seconds)) {
    doppler_cross_step_3(pos, u_time, audio, color);
  } else if(my_time < S(18.0, seconds)) {
    doppler_cross_step_4(pos, u_time, audio, color);
  } else if(my_time < S(19.0, seconds)) {
    doppler_cross_step_5(pos, u_time, audio, color);
  } else if(my_time < S(20.0, seconds)) {
    doppler_cross_step_6(pos, u_time, audio, color);
  } else if(my_time < S(21.0, seconds)) {
    doppler_cross_step(pos, u_time, audio, color);
  } else if(my_time < S(22.0, seconds)) {
    doppler_cross_step_0(pos, u_time, audio, color);
  } else if(my_time < S(23.0, seconds)) {
    doppler_pink_blue_sand(pos, u_time, audio, color);
  } else if(my_time < S(24.0, seconds)) {
    doppler_melting_square_glitch_fuck_with(pos, u_time, audio, color);
  } else if(my_time < S(25.0, seconds)) {
    doppler_melting_square_glitch(pos, u_time, audio, color);
  } else if(my_time < S(26.0, seconds)) {
    doppler_twisting_timer(pos, u_time, audio, color);
  } else if(my_time < S(27.0, seconds)) {
    doppler_trippy_melting_diamond(pos, u_time, audio, color);
  } else if(my_time < S(28.0, seconds)) {
    doppler_trippy_diamond(pos, u_time, audio, color);
  } else if(my_time < S(29.0, seconds)) {
    doppler_trippy_diamond_0(pos, u_time, audio, color);
  } else if(my_time < S(30.0, seconds)) {
    doppler_morph(pos, u_time, audio, color);
  } else if(my_time < S(31.0, seconds)) {
    doppler_morph_0(pos, u_time, audio, color);
  } else if(my_time < S(32.0, seconds)) {
    doppler_morph_1(pos, u_time, audio, color);
  } else if(my_time < S(33.0, seconds)) {
    doppler_morph_2(pos, u_time, audio, color);
  } else if(my_time < S(34.0, seconds)) {
    choppy_doppler_square_fractal_zoom_out(pos, u_time, audio, color);
  } else if(my_time < S(35.0, seconds)) {
    choppy_doppler_square_fractal_zoom_out_0(pos, u_time, audio, color);
  } else if(my_time < S(36.0, seconds)) {
    choppy_doppler_square_fractal_pulse(pos, u_time, audio, color);
  } else if(my_time < S(37.0, seconds)) {
    plaid_choppy_glossy(pos, u_time, audio, color);
  } else if(my_time < S(38.0, seconds)) {
    plaid_choppy_glossy_0(pos, u_time, audio, color);
  } else if(my_time < S(39.0, seconds)) {
    choppy_glossy_0(pos, u_time, audio, color);
  } else if(my_time < S(40.0, seconds)) {
    doppler_cross_plaid_glitch_0(pos, u_time, audio, color);
  } else if(my_time < S(41.0, seconds)) {
    doppler_cross_plaid(pos, u_time, audio, color);
  } else if(my_time < S(42.0, seconds)) {
    doppler_plaid(pos, u_time, audio, color);
  } else if(my_time < S(43.0, seconds)) {
    choppy_glossy(pos, u_time, audio, color);
  } else if(my_time < S(44.0, seconds)) {
    flossy_glossy(pos, u_time, audio, color);
  } else if(my_time < S(45.0, seconds)) {
    doppler_diamond_collide(pos, u_time, audio, color);
  } else if(my_time < S(46.0, seconds)) {
    doppler_step_pink_blue(pos, u_time, audio, color);
  } else if(my_time < S(47.0, seconds)) {
    doppler_step_pink_blue_0(pos, u_time, audio, color);
  } else if(my_time < S(48.0, seconds)) {
    doppler_step_pink_yellow(pos, u_time, audio, color);
  } else if(my_time < S(49.0, seconds)) {
    doppler_shaky_shaky(pos, u_time, audio, color);
  } else if(my_time < S(50.0, seconds)) {
    doppler_shaky_shaky_0(pos, u_time, audio, color);
  } else if(my_time < S(51.0, seconds)) {
    doppler_shaky_shaky_0b(pos, u_time, audio, color);
  } else if(my_time < S(52.0, seconds)) {
    doppler_shaky_shaky_1(pos, u_time, audio, color);
  } else if(my_time < S(53.0, seconds)) {
    doppler_shaky_shaky_2(pos, u_time, audio, color);
  } else if(my_time < S(54.0, seconds)) {
    doppler_shaky_shaky_3(pos, u_time, audio, color);
  } else if(my_time < S(55.0, seconds)) {
    doppler_shaky_blue(pos, u_time, audio, color);
  } else if(my_time < S(56.0, seconds)) {
    doppler_blue_fights_pink(pos, u_time, audio, color);
  } else {
    doppler_blue_fights_pink(pos, u_time, audio, color);
  }
}

void doppler_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  doppler_audio(pos, u_time, audio, color);       // Ba:sen Pool Party Dub Mix
  // doppler_blue_web(pos, u_time, audio, color);   // ooo
  // doppler_sharp_heart(pos, u_time, audio, color);   // Warrior
  // doppler_rainbow_heart(pos, u_time, audio, color);   // Superlove

  // doppler_sofias_rainbow(pos, u_time, audio, color);    // Loverus -> change all audio ot bandpass for main part of song
  // doppler_red_red_sun(pos, u_time, audio, color);     // Heaven Can Wait Intro and Verse
  // doppler_green_rooster(pos, u_time, audio, color);       // Heaven Can Wait Chorus
  // doppler_sun_star_rooster(pos, u_time, audio, color);
  // doppler_blue_cross_spinning(pos, u_time, audio, color);
  // doppler_blue_cross(pos, u_time, audio, color);
  // doppler_blue_step_cross_horizontal(pos, u_time, audio, color);   // H
  // doppler_blue_step_cross(pos, u_time, audio, color);
  // doppler_cross_step_1(pos, u_time, audio, color);

  // GOTTA GET BETTER COLORS FOR THE doppler_floating_X
  // doppler_floating_ring_morph(pos, u_time, audio, color);
  // doppler_floating_ring_morph_1(pos, u_time, audio, color);   // H
  // doppler_cross_step_2(pos, u_time, audio, color); // H
  // doppler_cross_step_3(pos, u_time, audio, color);  // H
  // doppler_cross_step_4(pos, u_time, audio, color); // H
  // doppler_cross_step_5(pos, u_time, audio, color);        // Back & Forth - Harris & Hurr
  // doppler_cross_step_6(pos, u_time, audio, color);
  // doppler_cross_step(pos, u_time, audio, color);
  // doppler_cross_step_0(pos, u_time, audio, color);

  // doppler_pink_blue_sand(pos, u_time, audio, color);
  // doppler_melting_square_glitch_fuck_with(pos, u_time, audio, color);    // meh
  // doppler_melting_square_glitch(pos, u_time, audio, color);
  // doppler_twisting_timer(pos, u_time, audio, color);
  // doppler_trippy_melting_diamond(pos, u_time, audio, color);
  // doppler_trippy_diamond(pos, u_time, audio, color);  // love
  // doppler_trippy_diamond_0(pos, u_time, audio, color);  // love

  // doppler_morph(pos, u_time, audio, color);  // HHH
  // doppler_morph_0(pos, u_time, audio, color);   // HHH superlove maybe
  // doppler_morph_1(pos, u_time, audio, color); // HHH
  // doppler_morph_2(pos, u_time, audio, color);

  // choppy_doppler_square_fractal_zoom_out(pos, u_time, audio, color);    // HH
  // choppy_doppler_square_fractal_zoom_out_0(pos, u_time, audio, color); // 4 The People
  // choppy_doppler_square_fractal_pulse(pos, u_time, audio, color);
  // plaid_choppy_glossy(pos, u_time, audio, color);
  // plaid_choppy_glossy_0(pos, u_time, audio, color);   // really like
  // choppy_glossy_0(pos, u_time, audio, color);
  // doppler_cross_plaid_glitch_0(pos, u_time, audio, color);    // Ada Lovelace
  // doppler_cross_plaid(pos, u_time, audio, color);    // Ada Lovelace
  // doppler_plaid(pos, u_time, audio, color); Lone Digger - Caravan Palace

  // choppy_glossy(pos, u_time, audio, color);
  // flossy_glossy(pos, u_time, audio, color);

  // doppler_diamond_collide(pos, u_time, audio, color);    // H for heavy house
  // doppler_step_pink_blue(pos, u_time, audio, color);     // classic doppler
  // doppler_step_pink_blue_0(pos, u_time, audio, color);
  // doppler_step_pink_yellow(pos, u_time, audio, color);
  // doppler_shaky_shaky(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_0(pos, u_time, audio, color);       // HHH! Ecstacy - Disclosure
  // doppler_shaky_shaky_0b(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_1(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_2(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_3(pos, u_time, audio, color);       // Ecstacy - Disclosure, oh yeah
  // doppler_shaky_blue(pos, u_time, audio, color);
  // doppler_blue_fights_pink(pos, u_time, audio, color);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  float seconds = 60.0;
  doppler_auto(pos, u_time, audio, color, seconds);

  // doppler_manual(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
