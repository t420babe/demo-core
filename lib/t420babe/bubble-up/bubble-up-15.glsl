// #effect #effectshape #fav2 #shadershoot
#ifndef T420BABE_BUBBLE_UP_15
#define T420BABE_BUBBLE_UP_15

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

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

  // vec4 ox = mod(p, abs(2.0 * audio.notch)) * abs(tan(u_time) + 0.0) + K2;
  vec4 ox = mod(p, abs(2.0 * audio.lowpass)) * (audio.notch);
  // vec4 oy = mod(floor(p * K), 1.0) * K  + K2;
  vec4 oy = mod(floor(p * K), 1.0) * K  + K2;

  vec4 dx = Pfx + jitter * ox;
  vec4 dy = Pfy + jitter * oy;

  // d11, d12, d21 and d22, squared
  vec4 d = dx * dx + dy * dy;

  // Sort out the two smallest distances
  #if 1
    // Cheat and pick only F1
    d.xy = min(d.wy, d.zw);
    d.x = max(d.x, d.y);

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

float random (in float x) {
    return fract(sin(x)*1e4);
}

float random (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float randomSerie(float x, float freq, float t) {
    return step(.8,random( floor(x*freq)-floor(t) ));
}

vec3 ikeda(vec2 pos, float time) {
    float cols = 1.5;
    // float freq = random(floor(time)) + abs(atan(time) * 0.1);
    // float freq = random(floor(time));
    float freq = 1.0;
    float t = 60. + time * (1.0 - freq) * 30.;

    if (fract(cols * 0.5) < 0.5){
        t *= -1.0;
    }
    t = 60.0;

    // freq += random(floor(pos.y));

    float offset = 0.025;
    return vec3(randomSerie(sin(pos.x), freq * 100.0, t + offset),
                 randomSerie(tan(pos.x), freq * 100.0, t),
                 randomSerie(cos(pos.x), freq * 100.0, t - offset));

}

void bubble_up_15(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float inv = 1.0;
  float zoom = 30.0 * inv;
  // pos.y += 0.20 * inv;
  // pos.y -= 0.20;
  pos *= zoom;

  vec2 F = cellular2x2(pos * 1.0);

  vec2 pos_tmp = pos - 0.0;
  float time = mod(u_time, 60.0 * 3.0) + 60.0;
  float a = dot(pos_tmp, pos_tmp) / time * 0.1;
  float n = step( abs( atan(a * 3.1415 * 5.0) ), F.x * abs(audio.notch * 0.5));

  color = vec3(n);
  color /= abs(audio.notch * 1.0);
  vec3 color_ikeda = ikeda(pos / zoom, time);
  color_ikeda += color;
  color = color_ikeda;
  // // Color 0
  // color.b =  abs(audio.highpass) * 1.5 * n;
  // color.r *= abs(sin(n * tan(u_time * 1.0)));
  // color.g *= abs(sin(n * tan(u_time * 1.0)));

  // // Color 1
  // float color_time = mod(u_time, 10.0);
  // color.b =  abs(audio.highpass) * 3.5 * n;
  // color.r *= abs(sin(n * abs(cos((PI / 4.0) * color_time * (audio.bandpass) + PI / 2.0))));
  // color.g /= abs(sin(n * abs(cos((PI / 4.0) * color_time * (audio.bandpass) + PI / 2.0))));
  // color.g *= abs(cos(n * abs(sin((PI / 4.0) * color_time * (audio.bandpass) ))));
}
#endif
