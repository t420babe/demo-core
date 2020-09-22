#ifdef GL_ES
precision mediump float;
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif


// uniform float full_min;
// uniform float full_ave;
// uniform float full_max;

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

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // doppler_step_pink_yellow(pos, u_time, audio, color);
  // wood_bb_hexagon_0(pos, u_time, audio, color);
  // wood_bb_red_tan_noise(pos, u_time, audio, color);
  // wood_bb_red_noise(pos, u_time, audio, color);
  // wbl_wood(pos, u_time, audio, color);
  // wbl2_wood(pos, u_time, audio, color);
  // wbl3_wood(pos, u_time, audio, color);
  // wbl4_wood(pos, u_time, audio, color);
  // caterpillar(pos, u_time, audio, color);
	// wbl5_wood(pos, u_time, audio, color);
	// wbl5b_wood(pos, u_time, audio, color);
	// wbl5c_wood(pos, u_time, audio, color);
	// wbl5d_wood(pos, u_time, audio, color);
	// wbl6_wood(pos, u_time, audio, color);
	// wbl7_wood(pos, u_time, audio, color);
  // wbl8_wood(pos, u_time, audio, color);
  // ridge_1_main(pos, u_time, audio, color);
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
  // r11_ridge_main(pos, u_time, audio, color);
  // r12_ridge_main(pos, u_time, audio, color);
  // r13_ridge_main(pos, u_time, audio, color);
  // r14_ridge_main(pos, u_time, audio, color);
  // r15_ridge_main(pos, u_time, audio, color);        // needs LOW qmetro ~5-10. i like 10nm rn   - This Girl (Kungs Vs Cookin' On 3 Burners) - Extended
  // r16_ridge_main(pos, u_time, audio, color);          // needs  30ms on qmetro
  // r17_ridge_main(pos, u_time, audio, color);
  // r18_ridge_main(pos, u_time, audio, color);
	// r19_ridge_main(pos, u_time, audio, color);
  // r20_ridge_main(pos, u_time, audio, color);   // yes yes yeh! I Feel So Band - The Kungs
  // r21_ridge_main(pos, u_time, audio, color);
  // r22_ridge_main(pos, u_time, audio, color);      // 60 ms on qmetro
  // r23_ridge_main(pos, u_time, audio, color);
  // r24_ridge_main(pos, u_time, audio, color);
  // r25_ridge_main(pos, u_time, audio, color);
	// r26_ridge_main(pos, u_time, audio, color);
	// r27_ridge_main(pos, u_time, audio, color);
  // couch(pos, u_time, audio, color);
  // couch_0(pos, u_time, audio, color);
  couch1(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
