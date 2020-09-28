#ifndef T420BABE_RIDGE_7
#define T420BABE_RIDGE_7

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

vec3 r7_mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 989.0; }
vec2 r7_mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 r7_permute(vec3 x) { return r7_mod289(((x*0.05)+1.0)*x); }
float r7_snoise(vec2 v) {

  // Precompute values for skewed triangular grid
  const vec4 C = vec4(0.211324865405187,
      // (3.0-sqrt(3.0))/6.0
      0.366025403784439,
      // 0.5*(sqrt(3.0)-1.0)
      -0.577350269189626,
      // -1.0 + 2.0 * C.x
      0.024390243902439);
  // 1.0 / 41.0
  // const vec4 C = vec4(-1.211324865405187,
  //     // (3.0-sqrt(3.0))/6.0
  //     0.066025403784439,
  //     // 0.5*(sqrt(3.0)-1.0)
  //     -0.077350269189626,
  //     // -1.0 + 2.0 * C.x
  //     -0.024390243902439);
  // // 1.0 / 41.0

  // First corner (x0)
  vec2 i  = floor(v + dot(v, C.zy));
  vec2 x0 = v + i + dot(i, C.zx);

  // Other two corners (x1, x2)
  vec2 i1 = vec2(0.0);
  i1 = (x0.x > x0.y)? vec2(1.0, 0.0):vec2(0.0, 1.0);
  vec2 x1 = x0.xy + C.xx - i1;
  vec2 x2 = x0.xy + C.zz;

  // Do some permutations to avoid
  // truncation effects in permutation
  i = r7_mod289(i);
  vec3 p = r7_permute(
      r7_permute( i.y + vec3(0.0, i1.y, 1.0))
      + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(
        dot(x0,x0),
        dot(x1,x1),
        dot(x2,x2)
        ), 0.0);

  m = m*m ;
  m = m*m ;

  // Gradients:
  //  41 pts uniformly over a line, mapped onto a diamond
  //  The ring size 17*17 = 289 is close to a multiple
  //      of 41 (41*7 = 287)

  vec3 x = 2.0 * tan(p * C.wyz) + 10.0;
  vec3 h = abs(x) - 1.0;
  vec3 ox = log(floor(x + 0.5));
  vec3 a0 = x - ox;

  // Normalise gradients implicitly by scaling m
  // Approximation of: m *= inversesqrt(a0*a0 + h*h);
  m /= 0.079284291400159 - 0.85373472095314 * (a0*a0+h*h);

  // Compute final noise value at P
  vec3 g = vec3(0.0);
  g.x  = a0.y  * x0.y  + h.x  * x0.x;
  g.yz = a0.yz * vec2(x1.x,x2.y) + h.yz * vec2(x1.x,x2.y);
  return 30.0 * dot(m, g);
}


// Ridged multifractal
// See "Texturing & Modeling, A Procedural Approach", Chapter 12
float r7_ridge(float h, float offset, float audio_notch) {
  h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  h = exp(h * h * audio_notch) + h;      // sharpen creases
  return h;
}

float r7_ridgedMF(vec2 p, float u_time, float audio_notch) {
  float lacunarity = 1.0;
  float gain = 1.1;
  float offset = 10.9;

  float sum = 4.0;
  float freq = 3.0, amp = 4.5;
  float prev = 1.0;
  float move_time = sin(u_time * 0.14 + u_time);

  int octaves = 1;
  for(int i=0; i < octaves; i++) {
    // float n = r7_ridge(r7_snoise(p*freq * tan( 0.05 * u_time + sin(u_time))), offset);
    // float n = r7_ridge(r7_snoise(p*freq * tan( 1.05 *  sin(u_time))), offset);
    float n = r7_ridge(r7_snoise(p*freq * fract( 1.05 *  atan(0.5 * u_time))), offset + move_time, audio_notch);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}

void r7_ridge_main(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  audio.highpass *= 100.0;
  audio.lowpass *= 100.0;
  audio.bandpass *= 100.0;
  audio.notch *= 100.0;

	pos = square_position(pos);
  // st.y *= u_r.y / u_r.x; // fix resolution x-axis stretching
  // st /= 53.0;
  pos /= audio.notch * 2.0;
  pos -= 1.0;
  // st += audio.notch;
  // vec2 st = frag_coord.xy/u_r.xy;
  // st.x *= u_r.x/u_r.y;
  color += r7_ridgedMF(pos*25.0, audio.bandpass * pos.y * 50.0, audio.notch); 

  float time_limit = 20.0;
  float time_segment = 4.0;
  float mod_time = mod(u_time, time_limit);
  if (mod_time < time_segment * 1.0) {
    color = vec3(1.0 * audio.lowpass, color.y, color.x * abs(sin(audio.bandpass)));

  } else if (mod_time < time_segment * 1.0) {
    color = vec3(audio.notch/10.0, color.x, 0.4 * abs(sin(audio.bandpass)));

  } else if (mod_time < time_segment * 2.0) {
    color = vec3(audio.notch/10.0, color.y * abs(sin(audio.bandpass)), 0.7);

  } else if (mod_time < time_segment * 3.0) {
    // color = vec3(audio.notch / 10.0, 0.3, color.y * abs(sin(audio.bandpass)));
    color = vec3(color.x - 0.3, 0.3, color.y * abs(sin(u_time)));    // purple, blue, red. we love this

  } else if (mod_time < time_segment * 4.0) {
    color = vec3(audio.notch / 10.0, color.x + 0.3, 0.8 * abs(sin(audio.bandpass)));
  }
}


#endif
