// #effect #effectshape #fav5 #shadershoot #needsong
#ifndef T420BABE_BUBBLE_UP_23
#define T420BABE_BUBBLE_UP_23

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_PERMUTE
#include "./lib/common/permute.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

// Permutation polynomial: (34x^2 + x) mod 289

vec2 cellular2x2(vec2 P) {

  float K = 0.142857142857;      // 1/7
  float K2 = 0.0;    // K/2
  float jitter = 0.01;

  vec2 Pi = mod((P), 289.0);
  vec2 Pf = tan(P * P);

  vec4 Pfx = Pf.x + vec4(-0.5, -1.5, -0.5, -1.5);
  vec4 Pfy = Pf.y + vec4(-0.5, -0.5, -1.5, -1.5);

  vec4 p = permute(Pi.x + vec4(0.0, 1.0, 0.0, 1.0));
  p = permute(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0));

  // vec4 ox = mod(p, abs(2.0 * audio.notch)) * abs(tan(u_time) + 0.0) + K2;
  vec4 ox = mod(p, abs(2.0 * audio.lowpass)) * (audio.notch);
  // vec4 oy = mod(floor(p * K), 1.0) * K  + K2;
  vec4 oy = mod(floor(p * K), 1.0) * K  + K2;

  vec4 dx = Pfx + jitter * ox;
  vec4 dy = Pfy + jitter * oy;

  // d11, d12, d21 and d22, squared
  vec4 d = dx * dx + dy * dy;

  // Sort out the two smallest distances
  // Cheat and pick only F1
  d.yx = max(d.wy, d.zw);
  d.x = min(d.x, d.y);

  return d.xx;                // F1 duplicated, F2 not computed

}

#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif
float aastep(float threshold, float value) {
#ifdef GL_OES_standard_derivatives
  float afwidth = 0.7 * length(vec2(dFdx(value), dFdy(value)));
  return smoothstep(threshold-afwidth, threshold+afwidth, value);
#else
  return step(threshold, value);
#endif
}


vec3 bubble_up_23(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);

  audio.lowpass   *= 5.5;
  audio.highpass  *= 5.5;
  audio.bandpass  *= 5.5;
  // audio.notch     *= 0.01;
  // audio.notch     *= 0.05;
  // audio.notch     *= 0.25;
  audio.notch     *= 0.01;

  vec3 color_bg = vec3(1.0);

  float inv = -1.0;
  float zoom = 70.0 * inv;
  // pos.y += 0.20 * inv;
  // pos.y -= 0.20;
  pos *= zoom;

  vec2 F = cellular2x2(pos * 1.0);

  vec2 pos_tmp = pos - 0.0;
  float time = mod(u_time, 60.0 * 6.0) + 666.0;
  float a = dot(pos_tmp, pos_tmp) / time * 0.07;
  // float n = step( abs( atan(a * 3.1415 * 5.0) ), F.x * sin(audio.notch * 0.10));
  float n = step( abs( log2(a * 3.1415 * 5.0) ), F.x * abs(audio.notch * 0.40));

  color = vec3(n);
  color *= abs(sin(audio.bandpass));
  // color.g /= abs(audio.notch);
  // color.r /= abs(audio.notch);
  // color /= abs(audio.notch);
  color /= abs(audio.notch);
  color /= abs(audio.notch);

  // color_bg = vec3(1.0, 1.0, 1.0);

  // ~30s
  color_bg = vec3(abs(tan(abs(sin(u_time)))), abs(cos(2.0 * audio.bandpass)) * 1.5, abs(sin(audio.highpass)));

  vec2 pos_bg = pos;
  pos_bg = (pos / zoom) * 0.5;
  pos_bg.y += 0.5;
  pos_bg.x += 0.5;


  // color = 1.0 - color;
  return color;
}
#endif
