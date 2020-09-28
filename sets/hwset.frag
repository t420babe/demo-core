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

void main_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 81.0);

  if (my_time < S(1.0, seconds)) {
    ridge_1_main(pos, u_time, audio, color);
  } else if(my_time < S(2.0, seconds)) {
    alligator(pos, u_time, audio, color);
  } else if(my_time < S(3.0, seconds)) {
    r1a_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(4.0, seconds)) {
    r2_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(5.0, seconds)) {
    r3_ridge_main(pos, u_time, audio, color);       // rly trippy alien, Mi Mujer
  } else if(my_time < S(6.0, seconds)) {
    r4_ridge_main(pos, u_time, audio, color);       // love this but need to encorpoate audio with some color changes more
  } else if(my_time < S(7.0, seconds)) {
    r5_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(8.0, seconds)) {
    r6_ridge_main(pos, u_time, audio, color);       // yes yes yes! Something to Say - Holow
  } else if(my_time < S(9.0, seconds)) {
    r7_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(10.0, seconds)) {
    r8_ridge_main(pos, u_time, audio, color);     // oh thats a fun one
  } else if(my_time < S(11.0, seconds)) {
    r9_ridge_main(pos, u_time, audio, color);     // works well with low qmetro rate, ~60 - 100 ms, 70ms i like rn, song: Warrior, Aluna
  } else if(my_time < S(12.0, seconds)) {
    r10_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(13.0, seconds)) {
    r11_ridge_main(pos, u_time, audio, color);     // HHH
  } else if(my_time < S(14.0, seconds)) {
    r12_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(15.0, seconds)) {
    r13_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(16.0, seconds)) {
    r14_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(17.0, seconds)) {
    r15_ridge_main(pos, u_time, audio, color);        // needs LOW qmetro ~5-10. i like 10nm rn   - This Girl (Kungs Vs Cookin' On 3 Burners) - Extended
  } else if(my_time < S(18.0, seconds)) {
    r16_ridge_main(pos, u_time, audio, color);          // needs  30ms on qmetro
  } else if(my_time < S(19.0, seconds)) {
    r17_ridge_main(pos, u_time, audio, color);    // H
  } else if(my_time < S(20.0, seconds)) {
    r18_ridge_main(pos, u_time, audio, color);     //  H
  } else if(my_time < S(21.0, seconds)) {
    r19_ridge_main(pos, u_time, audio, color);      // H
  } else if(my_time < S(22.0, seconds)) {
    r20_ridge_main(pos, u_time, audio, color);   // yes yes yeh! I Feel So Band - The Kungs
  } else if(my_time < S(23.0, seconds)) {
    r21_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(24.0, seconds)) {
    r22_ridge_main(pos, u_time, audio, color);      // 60 ms on qmetro
  } else if(my_time < S(25.0, seconds)) {
    r23_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(26.0, seconds)) {
    r24_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(27.0, seconds)) {
    r25_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(28.0, seconds)) {
    r26_ridge_main(pos, u_time, audio, color);
  } else if(my_time < S(29.0, seconds)) {
    sayin_sayin_digital_black_hole(pos, u_time, audio, color);
  } else if(my_time < S(30.0, seconds)) {
    sayin_sayin_sliding_in_cyan_square(pos, u_time, audio, color);
  } else if(my_time < S(31.0, seconds)) {
    sayin_sayin_sliding_in_cyan_square_og(pos, u_time, audio, color);
  } else if(my_time < S(32.0, seconds)) {
    sayin_sayin_sliding_in_0(pos, u_time, audio, color);
  } else if(my_time < S(31.0, seconds)) {
    sayin_sayin_sliding_in_1(pos, u_time, audio, color);
  } else if(my_time < S(32.0, seconds)) {
    sayin_sayin_sliding_in_2(pos, u_time, audio, color);    // H
  } else if(my_time < S(33.0, seconds)) {
    sayin_sayin_deep_blue(pos, u_time, audio, color);
  } else if(my_time < S(34.0, seconds)) {
    sayin_sayin_red(pos, u_time, audio, color);
  } else if(my_time < S(35.0, seconds)) {
    sayin_sayin_red_fracture(pos, u_time, audio, color);
  } else if(my_time < S(36.0, seconds)) {
    sayin_sayin_blue_single_fracture_0(pos, u_time, audio, color);
  } else if(my_time < S(37.0, seconds)) {
    sayin_sayin_blue_single_fracture_1(pos, u_time, audio, color);   // H favorite color combo
  } else if(my_time < S(38.0, seconds)) {
    sayin_sayin_blue_single_fracture_2(pos, u_time, audio, color);   // H favorite color combo
  } else if(my_time < S(39.0, seconds)) {
    sayin_sayin_blue_clock_arrow_0(pos, u_time, audio, color);  // H, really cool, Techno Disco
  } else if(my_time < S(40.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  } else if(my_time < S(41.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_0(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  } else if(my_time < S(42.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_1(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  } else if(my_time < S(43.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_2(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  } else if(my_time < S(44.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_3(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  } else if(my_time < S(45.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_3b(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  } else if(my_time < S(46.0, seconds)) {
    sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  } else if(my_time < S(47.0, seconds)) {
    x_box(pos, u_time, audio, color);
  } else if(my_time < S(47.0, seconds)) {
    pink_purple_x_max_oval(pos, u_time, audio, color);
  } else if(my_time < S(48.0, seconds)) {
    pink_purple_x_max(pos, u_time, audio, color);
  } else if(my_time < S(49.0, seconds)) {
    pink_purple_x_max_0(pos, u_time, audio, color);
  } else if(my_time < S(50.0, seconds)) {
    red_x_max(pos, u_time, audio, color);
  } else if(my_time < S(51.0, seconds)) {
    doppler_audio(pos, u_time, audio, color);
  } else if(my_time < S(52.0, seconds)) {
    doppler_blue_web(pos, u_time, audio, color);
  } else if(my_time < S(53.0, seconds)) {
    doppler_sharp_heart(pos, u_time, audio, color);
  } else if(my_time < S(54.0, seconds)) {
    doppler_rainbow_heart(pos, u_time, audio, color);
  } else if(my_time < S(55.0, seconds)) {
    doppler_sofias_rainbow(pos, u_time, audio, color);
  } else if(my_time < S(56.0, seconds)) {
    doppler_red_red_sun(pos, u_time, audio, color);
  } else if(my_time < S(57.0, seconds)) {
    doppler_green_rooster(pos, u_time, audio, color);
  } else if(my_time < S(58.0, seconds)) {
    doppler_sun_star_rooster(pos, u_time, audio, color);
  } else if(my_time < S(59.0, seconds)) {
    doppler_blue_cross_spinning(pos, u_time, audio, color);
  } else if(my_time < S(20.0, seconds)) {
    doppler_blue_cross(pos, u_time, audio, color);
  } else if(my_time < S(21.0, seconds)) {
    doppler_blue_step_cross_horizontal(pos, u_time, audio, color);
  } else if(my_time < S(22.0, seconds)) {
    doppler_blue_step_cross(pos, u_time, audio, color);
  } else if(my_time < S(23.0, seconds)) {
    doppler_cross_step_1(pos, u_time, audio, color);
  } else if(my_time < S(24.0, seconds)) {
    doppler_floating_ring_morph(pos, u_time, audio, color);
  } else if(my_time < S(25.0, seconds)) {
    doppler_floating_ring_morph_1(pos, u_time, audio, color);
  } else if(my_time < S(26.0, seconds)) {
    doppler_cross_step_2(pos, u_time, audio, color);
  } else if(my_time < S(27.0, seconds)) {
    doppler_cross_step_3(pos, u_time, audio, color);
  } else if(my_time < S(28.0, seconds)) {
    doppler_cross_step_4(pos, u_time, audio, color);
  } else if(my_time < S(29.0, seconds)) {
    doppler_cross_step_5(pos, u_time, audio, color);
  } else if(my_time < S(30.0, seconds)) {
    doppler_cross_step_6(pos, u_time, audio, color);
  } else if(my_time < S(31.0, seconds)) {
    doppler_cross_step(pos, u_time, audio, color);
  } else if(my_time < S(32.0, seconds)) {
    doppler_cross_step_0(pos, u_time, audio, color);
  } else if(my_time < S(33.0, seconds)) {
    doppler_pink_blue_sand(pos, u_time, audio, color);
  } else if(my_time < S(34.0, seconds)) {
    doppler_melting_square_glitch_fuck_with(pos, u_time, audio, color);
  } else if(my_time < S(35.0, seconds)) {
    doppler_melting_square_glitch(pos, u_time, audio, color);
  } else if(my_time < S(36.0, seconds)) {
    doppler_twisting_timer(pos, u_time, audio, color);
  } else if(my_time < S(37.0, seconds)) {
    doppler_trippy_melting_diamond(pos, u_time, audio, color);
  } else if(my_time < S(38.0, seconds)) {
    doppler_trippy_diamond(pos, u_time, audio, color);
  } else if(my_time < S(39.0, seconds)) {
    doppler_trippy_diamond_0(pos, u_time, audio, color);
  } else if(my_time < S(40.0, seconds)) {
    doppler_morph(pos, u_time, audio, color);
  } else if(my_time < S(41.0, seconds)) {
    doppler_morph_0(pos, u_time, audio, color);
  } else if(my_time < S(42.0, seconds)) {
    doppler_morph_1(pos, u_time, audio, color);
  } else if(my_time < S(43.0, seconds)) {
    doppler_morph_2(pos, u_time, audio, color);
  } else if(my_time < S(44.0, seconds)) {
    choppy_doppler_square_fractal_zoom_out(pos, u_time, audio, color);
  } else if(my_time < S(45.0, seconds)) {
    choppy_doppler_square_fractal_zoom_out_0(pos, u_time, audio, color);
  } else if(my_time < S(46.0, seconds)) {
    choppy_doppler_square_fractal_pulse(pos, u_time, audio, color);
  } else if(my_time < S(47.0, seconds)) {
    plaid_choppy_glossy(pos, u_time, audio, color);
  } else if(my_time < S(48.0, seconds)) {
    plaid_choppy_glossy_0(pos, u_time, audio, color);
  } else if(my_time < S(49.0, seconds)) {
    choppy_glossy_0(pos, u_time, audio, color);
  } else if(my_time < S(50.0, seconds)) {
    doppler_cross_plaid_glitch_0(pos, u_time, audio, color);
  } else if(my_time < S(51.0, seconds)) {
    doppler_cross_plaid(pos, u_time, audio, color);
  } else if(my_time < S(52.0, seconds)) {
    doppler_plaid(pos, u_time, audio, color);
  } else if(my_time < S(53.0, seconds)) {
    choppy_glossy(pos, u_time, audio, color);
  } else if(my_time < S(54.0, seconds)) {
    flossy_glossy(pos, u_time, audio, color);
  } else if(my_time < S(55.0, seconds)) {
    doppler_diamond_collide(pos, u_time, audio, color);
  } else if(my_time < S(56.0, seconds)) {
    doppler_step_pink_blue(pos, u_time, audio, color);
  } else if(my_time < S(57.0, seconds)) {
    doppler_step_pink_blue_0(pos, u_time, audio, color);
  } else if(my_time < S(58.0, seconds)) {
    doppler_step_pink_yellow(pos, u_time, audio, color);
  } else if(my_time < S(59.0, seconds)) {
    doppler_shaky_shaky(pos, u_time, audio, color);
  } else if(my_time < S(60.0, seconds)) {
    doppler_shaky_shaky_0(pos, u_time, audio, color);
  } else if(my_time < S(61.0, seconds)) {
    doppler_shaky_shaky_0b(pos, u_time, audio, color);
  } else if(my_time < S(62.0, seconds)) {
    doppler_shaky_shaky_1(pos, u_time, audio, color);
  } else if(my_time < S(63.0, seconds)) {
    doppler_shaky_shaky_2(pos, u_time, audio, color);
  } else if(my_time < S(64.0, seconds)) {
    doppler_shaky_shaky_3(pos, u_time, audio, color);
  } else if(my_time < S(65.0, seconds)) {
    doppler_shaky_blue(pos, u_time, audio, color);
  } else if(my_time < S(66.0, seconds)) {
    doppler_blue_fights_pink(pos, u_time, audio, color);
  } else if(my_time < S(67.0, seconds)) {
    wood_bb_hexagon_0(pos, u_time, audio, color);
  } else if(my_time < S(68.0, seconds)) {
    wood_bb_red_tan_noise(pos, u_time, audio, color);
  } else if(my_time < S(69.0, seconds)) {
    wood_bb_red_noise(pos, u_time, audio, color);
  } else if(my_time < S(70.0, seconds)) {
    wbl_wood(pos, u_time, audio, color);
  } else if(my_time < S(71.0, seconds)) {
    wbl1_wood(pos, u_time, audio, color);
  } else if(my_time < S(72.0, seconds)) {
    wbl2_wood(pos, u_time, audio, color);
  } else if(my_time < S(73.0, seconds)) {
    caterpillar(pos, u_time, audio, color);
  } else if(my_time < S(74.0, seconds)) {
    wbl5_wood(pos, u_time, audio, color);
  } else if(my_time < S(75.0, seconds)) {
    wbl5b_wood(pos, u_time, audio, color);
  } else if(my_time < S(76.0, seconds)) {
    wbl5c_wood(pos, u_time, audio, color);
  } else if(my_time < S(77.0, seconds)) {
    wbl5d_wood(pos, u_time, audio, color);
  } else if(my_time < S(78.0, seconds)) {
    wbl6_wood(pos, u_time, audio, color);
  } else if(my_time < S(79.0, seconds)) {
    wbl7_wood(pos, u_time, audio, color);
  } else if(my_time < S(80.0, seconds)) {
    wbl8_wood(pos, u_time, audio, color);
  } else {
    sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  }
}

void main_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // // qmetro: 20
  // wood_bb_hexagon_0(pos, u_time, audio, color);    // good
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


  // // qmetro: 45 ok
  // ridge_1_main(pos, u_time, audio, color);
  // alligator(pos, u_time, audio, color);
  // r1a_ridge_main(pos, u_time, audio, color);
  // r2_ridge_main(pos, u_time, audio, color);
  // r3_ridge_main(pos, u_time, audio, color);       // rly trippy alien, Mi Mujer
  // r4_ridge_main(pos, u_time, audio, color);       // love this but need to encorpoate audio with some color changes more
  // r5_ridge_main(pos, u_time, audio, color);
  // r6_ridge_main(pos, u_time, audio, color);       // yes yes yes! Something to Say - Holow
  // r6a_ridge_main(pos, u_time, audio, color);       // yes yes yes! Something to Say - Holow
  // r7_ridge_main(pos, u_time, audio, color);
  // r8_ridge_main(pos, u_time, audio, color);     // oh thats a fun one
  // r9_ridge_main(pos, u_time, audio, color);     // works well with low qmetro rate, ~60 - 100 ms, 70ms i like rn, song: Warrior, Aluna
  // r10_ridge_main(pos, u_time, audio, color);
  // r11_ridge_main(pos, u_time, audio, color);     // HHH
  // r12_ridge_main(pos, u_time, audio, color);
  // r13_ridge_main(pos, u_time, audio, color);
  // r14_ridge_main(pos, u_time, audio, color);
  // r15_ridge_main(pos, u_time, audio, color);        // needs LOW qmetro ~5-10. i like 10nm rn   - This Girl (Kungs Vs Cookin' On 3 Burners) - Extended
  // r16_ridge_main(pos, u_time, audio, color);          // needs  30ms on qmetro
  // r17_ridge_main(pos, u_time, audio, color);    // H
  // r18_ridge_main(pos, u_time, audio, color);     //  H
  // r19_ridge_main(pos, u_time, audio, color);      // H
  // r20_ridge_main(pos, u_time, audio, color);   // yes yes yeh! I Feel So Band - The Kungs
  // r21_ridge_main(pos, u_time, audio, color);
  // r22_ridge_main(pos, u_time, audio, color);      // 60 ms on qmetro
  // r23_ridge_main(pos, u_time, audio, color);
  // r24_ridge_main(pos, u_time, audio, color);
  // r25_ridge_main(pos, u_time, audio, color);
  // r26_ridge_main(pos, u_time, audio, color);


  // // qmetro: 30 ok
  // sayin_sayin_digital_black_hole(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_cyan_square(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_cyan_square_og(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_0(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_1(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_2(pos, u_time, audio, color);    // H
  // sayin_sayin_deep_blue(pos, u_time, audio, color);
  // sayin_sayin_red(pos, u_time, audio, color);
  // sayin_sayin_red_fracture(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture_0(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture_1(pos, u_time, audio, color);   // H favorite color combo
  // sayin_sayin_blue_single_fracture_2(pos, u_time, audio, color);   // H favorite color combo
  // sayin_sayin_blue_clock_arrow_0(pos, u_time, audio, color);  // H, really cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og_0(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og_1(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og_2(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  // sayin_sayin_blue_wiggly_clock_og_3b(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  // sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  // sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind


  // // qmetro: 30, 45 ok
  // x_box(pos, u_time, audio, color);
  // pink_purple_x_max_oval(pos, u_time, audio, color);
  // pink_purple_x_max(pos, u_time, audio, color);
  // pink_purple_x_max_0(pos, u_time, audio, color);
  // pink_purple_x_max_1(pos, u_time, audio, color); // Sosa
  // red_x_max(pos, u_time, audio, color);


  // // qmetro: 30, 45 ok
  // purple_concentric(pos, u_time, audio, color);
  // green_concentric(pos, u_time, audio, color);
  // purple_circle(pos, u_time, audio, color);
  // orange_circle_bright_purple_bg(pos, u_time, audio, color);

  // qmetro: 30, 20 totally ok
  // doppler_audio(pos, u_time, audio, color);       // Ba:sen Pool Party Dub Mix
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

  // couch_0(pos, u_time, audio, color);
  // couch2(pos, u_time, audio, color);
  // couch3(pos, u_time, audio, color);
  // couch4(pos, u_time, audio, color);
  // couch5(pos, u_time, audio, color);
  // couch6(pos, u_time, audio, color);
  // couch7(pos, u_time, audio, color);      // H
  // couch8(pos, u_time, audio, color);      // H
  // couch9(pos, u_time, audio, color);        // H
  // couch10(pos, u_time, audio, color);     // HH
  // couch11(pos, u_time, audio, color);
  // couch12(pos, u_time, audio, color);
  // couch13(pos, u_time, audio, color);
  // couch14(pos, u_time, audio, color);
  // couch15(pos, u_time, audio, color);
  // couch16(pos, u_time, audio, color);     // HHH
  // couch17(pos, u_time, audio, color);      // HHH
  // couch18(pos, u_time, audio, color);
  // couch23(pos, u_time, audio, color);
  // couch24(pos, u_time, audio, color);
  // couch25(pos, u_time, audio, color);
  couch26(pos, u_time, audio, color);     // H
  // couch27(pos, u_time, audio, color);
  // couch28(pos, u_time, audio, color);     // H
  // couch29(pos, u_time, audio, color);       // H
  // couch30(pos, u_time, audio, color);
  // couch40(pos, u_time, audio, color);
  // couch41(pos, u_time, audio, color);
  // couch42(pos, u_time, audio, color);		// i like this one a lot
  // couch43(pos, u_time, audio, color);
  // couch44(pos, u_time, audio, color);
  // couch45(pos, u_time, audio, color);
  // couch46(pos, u_time, audio, color);
  // couch47(pos, u_time, audio, color);
  // couch48(pos, u_time, audio, color);
  // couch49(pos, u_time, audio, color);
  // couch50(pos, u_time, audio, color);
  // couch51(pos, u_time, audio, color);
  // couch52(pos, u_time, audio, color);
  // couch53(pos, u_time, audio, color);
  // couch54(pos, u_time, audio, color);
  // couch55(pos, u_time, audio, color);
  // couch56(pos, u_time, audio, color);
  // couch57(pos, u_time, audio, color);
  // couch58(pos, u_time, audio, color);
  // couch59(pos, u_time, audio, color);
  // couch60(pos, u_time, audio, color);
  // couch61(pos, u_time, audio, color);
  // couch62(pos, u_time, audio, color);
  // couch63(pos, u_time, audio, color);
  // couch64(pos, u_time, audio, color);
  // couch65(pos, u_time, audio, color);
  // couch66(pos, u_time, audio, color);
  // couch67(pos, u_time, audio, color);
  // couch68(pos, u_time, audio, color);
  // couch69(pos, u_time, audio, color);
  // couch70(pos, u_time, audio, color);
  // couch71(pos, u_time, audio, color);
  // couch72(pos, u_time, audio, color);
  // couch73(pos, u_time, audio, color);
  // couch74(pos, u_time, audio, color);
  // couch75(pos, u_time, audio, color);
  // couch76(pos, u_time, audio, color);
  // couch77(pos, u_time, audio, color);
  // couch78(pos, u_time, audio, color);
  // couch79(pos, u_time, audio, color);
  // couch80(pos, u_time, audio, color);
  // couch81(pos, u_time, audio, color);
  // couch82(pos, u_time, audio, color);
  // couch83(pos, u_time, audio, color);
  // couch84(pos, u_time, audio, color);
  // couch85(pos, u_time, audio, color);
  // couch86(pos, u_time, audio, color);
  // couch87(pos, u_time, audio, color);
  // couch88(pos, u_time, audio, color);
  // couch89(pos, u_time, audio, color);
  // couch90(pos, u_time, audio, color);
  // couch91(pos, u_time, audio, color);
  // couch92(pos, u_time, audio, color);
  // couch93(pos, u_time, audio, color);
  // couch94(pos, u_time, audio, color);
  // couch95(pos, u_time, audio, color);
  // couch96(pos, u_time, audio, color);
  // couch97(pos, u_time, audio, color);
  // couch98(pos, u_time, audio, color);
  // couch99(pos, u_time, audio, color);
  // couch100(pos, u_time, audio, color);
  // couch101(pos, u_time, audio, color);
  // couch102(pos, u_time, audio, color);
  // couch103(pos, u_time, audio, color);
  // couch104(pos, u_time, audio, color);
  // couch105(pos, u_time, audio, color);
  // couch106(pos, u_time, audio, color);
  // couch107(pos, u_time, audio, color);
  // couch108(pos, u_time, audio, color);
  // couch109(pos, u_time, audio, color);
  // couch110(pos, u_time, audio, color);
  // couch111(pos, u_time, audio, color);
  // couch112(pos, u_time, audio, color);
  // couch113(pos, u_time, audio, color);
  // couch114(pos, u_time, audio, color);
  // couch115(pos, u_time, audio, color);
  // couch116(pos, u_time, audio, color);
  // couch117(pos, u_time, audio, color);
  // couch118(pos, u_time, audio, color);
  // couch119(pos, u_time, audio, color);
  // couch120(pos, u_time, audio, color);
  // couch121(pos, u_time, audio, color);
  // couch122(pos, u_time, audio, color);
  // couch123(pos, u_time, audio, color);
  // couch124(pos, u_time, audio, color);
  // couch125(pos, u_time, audio, color);
  // couch126(pos, u_time, audio, color);
  // couch127(pos, u_time, audio, color);
  // couch128(pos, u_time, audio, color);
  // couch129(pos, u_time, audio, color);
  // couch130(pos, u_time, audio, color);		// i like this one a lot, yeah thats cool
  // couch131(pos, u_time, audio, color);
  // couch132(pos, u_time, audio, color);
  // couch133(pos, u_time, audio, color);
  // couch134(pos, u_time, audio, color);
  // couch135(pos, u_time, audio, color);
  // couch136(pos, u_time, audio, color);
  // couch137(pos, u_time, audio, color);
  // couch138(pos, u_time, audio, color);
  // couch139(pos, u_time, audio, color);
  // couch140(pos, u_time, audio, color);
  // couch141(pos, u_time, audio, color);
  // couch142(pos, u_time, audio, color);
  // couch143(pos, u_time, audio, color);
  // couch144(pos, u_time, audio, color);
  // couch145(pos, u_time, audio, color);
  // couch146(pos, u_time, audio, color);
  // couch147(pos, u_time, audio, color);
  // couch148(pos, u_time, audio, color);
  // couch149(pos, u_time, audio, color);
  // couch150(pos, u_time, audio, color);
  // couch151(pos, u_time, audio, color);			// i like this one
  // couch152(pos, u_time, audio, color);
  // couch153(pos, u_time, audio, color);
  // couch154(pos, u_time, audio, color);
  // couch155(pos, u_time, audio, color);
  // couch156(pos, u_time, audio, color);
  // couch157(pos, u_time, audio, color);
  // couch158(pos, u_time, audio, color);
  // couch159(pos, u_time, audio, color);
  // couch160(pos, u_time, audio, color);
  // couch161(pos, u_time, audio, color);
  // couch162(pos, u_time, audio, color);
  // couch163(pos, u_time, audio, color);
  // couch164(pos, u_time, audio, color);
  // couch165(pos, u_time, audio, color);
  // couch166(pos, u_time, audio, color);
  // couch167(pos, u_time, audio, color);
  // couch168(pos, u_time, audio, color);
  // couch169(pos, u_time, audio, color);
  // couch170(pos, u_time, audio, color);
  // couch171(pos, u_time, audio, color);
  // couch172(pos, u_time, audio, color);
  // couch173(pos, u_time, audio, color);
  // couch174(pos, u_time, audio, color);
  // couch175(pos, u_time, audio, color);
  // couch176(pos, u_time, audio, color);
  // couch177(pos, u_time, audio, color);
  // couch178(pos, u_time, audio, color);
  // couch179(pos, u_time, audio, color);
  // couch180(pos, u_time, audio, color);
  // couch181(pos, u_time, audio, color);
  // couch182(pos, u_time, audio, color);			// simple but i like it:noh
  // couch183(pos, u_time, audio, color);
  // couch184(pos, u_time, audio, color);
  // couch185(pos, u_time, audio, color);
  // couch186(pos, u_time, audio, color);
  // couch187(pos, u_time, audio, color);
  // couch188(pos, u_time, audio, color);
  // couch189(pos, u_time, audio, color);
  // couch190(pos, u_time, audio, color);
  // couch191(pos, u_time, audio, color);
  // couch192(pos, u_time, audio, color);
  // couch193(pos, u_time, audio, color);
  // couch194(pos, u_time, audio, color);
  // couch195(pos, u_time, audio, color);
  // couch196(pos, u_time, audio, color);
  // couch197(pos, u_time, audio, color);
  // couch198(pos, u_time, audio, color);
  // couch199(pos, u_time, audio, color);
  // couch200(pos, u_time, audio, color);
  // couch201(pos, u_time, audio, color);
  // couch202(pos, u_time, audio, color);
  // couch203(pos, u_time, audio, color);
  // couch204(pos, u_time, audio, color);
  // couch205(pos, u_time, audio, color);
  // couch206(pos, u_time, audio, color);
  // couch207(pos, u_time, audio, color);
  // couch208(pos, u_time, audio, color);
  // couch209(pos, u_time, audio, color);
  // couch210(pos, u_time, audio, color);
  // couch211(pos, u_time, audio, color);
  // couch212(pos, u_time, audio, color);
  // couch212(pos, u_time, audio, color);
  // couch213(pos, u_time, audio, color);
  // couch214(pos, u_time, audio, color);
  // couch215(pos, u_time, audio, color);
  // couch216(pos, u_time, audio, color);
  // couch217(pos, u_time, audio, color);
  // couch218(pos, u_time, audio, color);
  // couch219(pos, u_time, audio, color);
  // couch220(pos, u_time, audio, color);
  // couch221(pos, u_time, audio, color);
  // couch222(pos, u_time, audio, color);
  // couch223(pos, u_time, audio, color);
  // couch1(pos, u_time, audio, color); // HHH
  //
  //
  //
  // r20_ridge_main(pos, u_time, audio, color);   // yes yes yeh! I Feel So Band - The Kungs
  // couch182(pos, u_time, audio, color);			// simple but i like it:noh
  // wbl8_wood(pos, u_time, audio, color);
  // r17_ridge_main(pos, u_time, audio, color);    // H
  // r19_ridge_main(pos, u_time, audio, color);      // H
}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // float seconds = 60.0;
  // main_auto(pos, u_time, audio, color, seconds);

  main_manual(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
