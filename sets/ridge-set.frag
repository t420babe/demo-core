/* target qmetro: 60 ms but can set it and forget it at 45 ms */
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

void ridge_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 30.0);

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
  } else {
    r11_ridge_main(pos, u_time, audio, color);     // HHH
  }
}

void ridge_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  ridge_1_main(pos, u_time, audio, color);
  // alligator(pos, u_time, audio, color);
  // r1a_ridge_main(pos, u_time, audio, color);
  // r2_ridge_main(pos, u_time, audio, color);
  // r3_ridge_main(pos, u_time, audio, color);       // rly trippy alien, Mi Mujer
  // r4_ridge_main(pos, u_time, audio, color);       // love this but need to encorpoate audio with some color changes more
  // r5_ridge_main(pos, u_time, audio, color);
  // r6_ridge_main(pos, u_time, audio, color);       // yes yes yes! Something to Say - Holow
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
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  float seconds = 60.0;
  ridge_auto(pos, u_time, audio, color, seconds);

  // ridge_manual(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
