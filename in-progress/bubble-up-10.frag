#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef BOS_TURBULENCE
#include "./lib/bos/turbulence.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Permutation polynomial: (34x^2 + x) mod 289
vec4 permute(vec4 x) {
  return mod((34.0 * x + audio.bandpass) * x, 289.0);
}

vec2 cellular2x2(vec2 P) {

  float K = 0.142857142857;      // 1/7
  float K2 = 0.0;    // K/2
  float jitter = 0.01;

  vec2 Pi = mod((P), 289.0);
  vec2 Pf = sin(P);

  vec4 Pfx = Pf.x + vec4(-0.5, -1.5, -0.5, -1.5);
  vec4 Pfy = Pf.y + vec4(-0.5, -0.5, -1.5, -1.5);

  vec4 p = permute(Pi.x + vec4(0.0, 1.0, 0.0, 1.0));
  p = permute(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0));

  vec4 ox = mod(p, abs(2.0 * audio.notch)) * abs(tan(u_time)) + K2;
  vec4 oy = mod(floor(p * K), 1.0) * K + K2;

  vec4 dx = Pfx + jitter * ox;
  vec4 dy = Pfy + jitter * oy;

  // d11, d12, d21 and d22, squared
  vec4 d = dx * dx + dy * dy;

  // Sort out the two smallest distances
  #if 1
    // Cheat and pick only F1
    d.xy = min(d.xy, d.zw);
    d.x = min(d.x, d.y);

    return d.xx;                // F1 duplicated, F2 not computed

  #else
    // Do it right and find both F1 and F2
    d.xy = (d.x < d.y) ? d.xy : d.yx; // Swap if smaller
    d.xz = (d.x < d.z) ? d.xz : d.zx;
    d.xw = (d.x < d.w) ? d.xw : d.wx;

    d.y = min(d.y, d.z);
    d.y = min(d.y, d.w);

    return sqrt(d.xy);
  #endif

}


void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec2 st = pos;
  // pos = pos.yx;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);
  float inv = 1.0;
  float zoom = 1.0 * inv;
  // pos.y += 0.20 * inv;
  // pos.y -= 0.20;
  pos *= zoom;

  vec2 F = cellular2x2(pos * 1.0);

  vec2 pos_tmp = pos - 0.0;
  float time = mod(u_time, 60.0 * 3.0);
  float a = dot(pos_tmp, pos_tmp) - time * 0.1;
  // float n = step( abs( sin(a * 3.1415 * 5.0) ), F.x * F.x * abs(audio.notch));
  float n = step( abs( sin(a * 3.1415 * 5.0) ), F.x * abs(audio.notch));

  color = vec3(n);
  // Color 2

  // color.g = 0.6;
  // color.r = 1.0;
  // color.g *= clamp(cos(u_time * 0.5), 0.4, 0.8) + 0.3;
  // color.r *= abs(tan(n * sin(u_time * 0.5)));
  // color.b *= abs(sin(n * tan(u_time * 0.5) + 3.14 / 2.0));
  //
  // // COlor 1
  color.g = 0.6;
  color.g *= clamp(cos(u_time * 0.5), 0.4, 0.8) + 0.3;
  color.r *= abs(tan(n * sin(u_time * 0.5)));
  color.b *= abs(sin(n * tan(u_time * 0.5) + 3.14 / 2.0));

  // // Color 0
  // color.b *= abs(tan(n * sin(u_time)));
  // color.r *= abs(sin(n * tan(u_time) + 3.14 / 2.0));

  gl_FragColor = vec4(color, 1.0);
}
