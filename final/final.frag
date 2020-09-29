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

void final_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 81.0);
}

void final_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // r20_ridge_main(pos, u_time, audio, color);   // yes yes yeh! I Feel So Band - The Kungs
  couch26(pos, u_time, audio, color);     // H
  couch182(pos, u_time, audio, color);			// simple but i like it:noh

  couch82(pos, u_time, audio, color);     // HHH

  couch3e(pos, u_time, audio, color);
  couch3f(pos, u_time, audio, color);
  couch3b(pos, u_time, audio, color);
  couch3(pos, u_time, audio, color);
  couch3i(pos, u_time, audio, color);   // Trauma
  couch8(pos, u_time, audio, color);      // H
  couch9(pos, u_time, audio, color);        // H
  couch10(pos, u_time, audio, color);     // HH, get more lines in like couch12 has
  couch12(pos, u_time, audio, color);   // HHHH AMAZING esp after something noisey

  // couch14(pos, u_time, audio, color);   // ikedo it bb

  couch16(pos, u_time, audio, color);     // HHH
  couch17(pos, u_time, audio, color);      // HHH

  couch28(pos, u_time, audio, color);     // HHHH
  couch29(pos, u_time, audio, color);       // HHHH YES

  // couch42(pos, u_time, audio, color);		// i like this one a lot, but i need to incorporate much more audio
  couch43(pos, u_time, audio, color);
  couch44(pos, u_time, audio, color);
  couch46(pos, u_time, audio, color);
  couch48(pos, u_time, audio, color);   // HHH yes
  couch49(pos, u_time, audio, color);
  couch50(pos, u_time, audio, color);   // MMHHH NICE visual break from the nosier quads
  couch51(pos, u_time, audio, color);
  couch53(pos, u_time, audio, color);
  couch55(pos, u_time, audio, color);
  couch56(pos, u_time, audio, color);
  couch58(pos, u_time, audio, color);
  couch59(pos, u_time, audio, color);
  couch60(pos, u_time, audio, color);
  couch61(pos, u_time, audio, color);
  couch62(pos, u_time, audio, color);     // HHH
  couch63(pos, u_time, audio, color);     // HH
  couch64(pos, u_time, audio, color);
  couch65(pos, u_time, audio, color);
  couch66(pos, u_time, audio, color);
  couch72(pos, u_time, audio, color);
  couch73(pos, u_time, audio, color);
  couch74(pos, u_time, audio, color);
  couch75(pos, u_time, audio, color);
  couch76(pos, u_time, audio, color);
  couch77(pos, u_time, audio, color);
  couch78(pos, u_time, audio, color);
  couch79(pos, u_time, audio, color);
  couch80(pos, u_time, audio, color);
  couch81(pos, u_time, audio, color); // HH
  couch83(pos, u_time, audio, color);
  couch84(pos, u_time, audio, color);
  couch85(pos, u_time, audio, color);
  couch86(pos, u_time, audio, color);
  couch87(pos, u_time, audio, color);

  couch89(pos, u_time, audio, color);
  couch96(pos, u_time, audio, color);   // Maybe
  couch98(pos, u_time, audio, color);
  couch101(pos, u_time, audio, color);    /// should make more of this with different colors
  couch102(pos, u_time, audio, color);
  // couch103(pos, u_time, audio, color);
  couch104(pos, u_time, audio, color);
  couch105(pos, u_time, audio, color);
  // couch106(pos, u_time, audio, color);
  // couch108(pos, u_time, audio, color);     // make top strip and bottom stripe same height
  couch109(pos, u_time, audio, color);
  couch110(pos, u_time, audio, color);
  couch111(pos, u_time, audio, color);
  couch112(pos, u_time, audio, color);
  couch113(pos, u_time, audio, color);    // HHH
  couch114(pos, u_time, audio, color);
  couch115(pos, u_time, audio, color);

  // couch127(pos, u_time, audio, color);   // Maybee
  couch136c(pos, u_time, audio, color);   // All I Need - Nora En Pure
  couch150(pos, u_time, audio, color);  // Alone - Lost Frequencies Remix - Alan Walker, Lost Frequencies
  couch155(pos, u_time, audio, color);
  couch156(pos, u_time, audio, color);
  couch157(pos, u_time, audio, color);
  couch160(pos, u_time, audio, color);
  couch162(pos, u_time, audio, color);
  couch163(pos, u_time, audio, color);
  // couch164(pos, u_time, audio, color);
  couch165(pos, u_time, audio, color);
  couch166(pos, u_time, audio, color);
  couch167(pos, u_time, audio, color); // H
  couch168(pos, u_time, audio, color);
  couch169(pos, u_time, audio, color);
  couch170(pos, u_time, audio, color);
  couch172(pos, u_time, audio, color);
  couch174(pos, u_time, audio, color);
  couch175(pos, u_time, audio, color);
  couch176(pos, u_time, audio, color);
  // couch177(pos, u_time, audio, color);
  // couch178(pos, u_time, audio, color);
  couch179(pos, u_time, audio, color);
  couch187(pos, u_time, audio, color);
  couch189(pos, u_time, audio, color);
  couch190(pos, u_time, audio, color);
  couch191(pos, u_time, audio, color);
  couch194(pos, u_time, audio, color);
  couch208(pos, u_time, audio, color);
  couch211(pos, u_time, audio, color);
  couch212(pos, u_time, audio, color);
  couch213(pos, u_time, audio, color);
  couch1(pos, u_time, audio, color);
  couch215(pos, u_time, audio, color);
  couch216(pos, u_time, audio, color);
  couch218(pos, u_time, audio, color);
  couch219(pos, u_time, audio, color);
  couch220(pos, u_time, audio, color);

  // wbl8_wood(pos, u_time, audio, color);
  // r17_ridge_main(pos, u_time, audio, color);    // H
  // r19_ridge_main(pos, u_time, audio, color);      // H
}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // float seconds = 60.0;
  // final_auto(pos, u_time, audio, color, seconds);

  final_manual(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}

