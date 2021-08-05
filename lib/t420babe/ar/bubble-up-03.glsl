// #effect #trippy
#ifndef T420BABE_BUBBLE_UP_03
#define T420BABE_BUBBLE_UP_03

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

void bubble_up_03(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float zoom = 0.5;
  pos.y -= 0.3;
  pos *= zoom;

  vec2 F = cellular2x2(pos * 10.0);

  vec2 pos_tmp = pos - 0.0;
  float a = dot(pos_tmp, pos_tmp) - u_time * 0.1;
  float n = step( abs( sin(a * 3.1415 * 5.0) ), F.x * 2.0);

  color = vec3(n);
  color.b *= abs(tan(n * sin(u_time)));
  color.r *= abs(sin(n * tan(u_time) + 3.14 / 2.0));
  // color.g *= abs(audio.bandpass);
}
#endif
