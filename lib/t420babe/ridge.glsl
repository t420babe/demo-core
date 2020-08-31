#ifndef T420BABE_RIDGE
// t420babe song suggestion: Brain Juice by DARK $
// t420babe idea: black and white then when beat drop add in color

#ifndef COMMON_COMMON
#include "./lib/common/common.glsl"
#endif
// Inspiration and original functions by @patriciogv - 2015, Tittle: Ridge

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }

// Description : GLSL 2D simplex noise function
//      Author : Ian McEwan, Ashima Arts
//  Maintainer : ijm
//     Lastmod : 20110822 (ijm)
//     License :
//  Copyright (C) 2011 Ashima Arts. All rights reserved.
//  Distributed under the MIT License. See LICENSE file.
//  https://github.com/ashima/webgl-noise
float snoise(vec2 v) {

  // Precompute values for skewed triangular grid
  const vec4 C = vec4(0.211324865405187,
      // (3.0-sqrt(3.0))/6.0
      0.366025403784439,
      // 0.5*(sqrt(3.0)-1.0)
      -0.577350269189626,
      // -1.0 + 2.0 * C.x
      0.024390243902439);
  // 1.0 / 41.0

  // First corner (x0)
  vec2 i  = floor(v + dot(v, C.yy));
  vec2 x0 = v - i + dot(i, C.xx);

  // Other two corners (x1, x2)
  vec2 i1 = vec2(0.0);
  i1 = (x0.x > x0.y)? vec2(1.0, 0.0):vec2(0.0, 1.0);
  vec2 x1 = x0.xy + C.xx - i1;
  vec2 x2 = x0.xy + C.zz;

  // Do some permutations to avoid
  // truncation effects in permutation
  i = mod289(i);
  vec3 p = permute(
      permute( i.y + vec3(0.0, i1.y, 1.0))
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

  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = log(floor(x + 0.5));
  vec3 a0 = x - ox;

  // Normalise gradients implicitly by scaling m
  // Approximation of: m *= inversesqrt(a0*a0 + h*h);
  m /= 1.79284291400159 - 0.85373472095314 * (a0*a0+h*h);

  // Compute final noise value at P
  vec3 g = vec3(0.0);
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * vec2(x1.x,x2.x) + h.yz * vec2(x1.y,x2.y);
  return 130.0 * dot(m, g);
}

#define OCTAVES 25

// Ridged multifractal
// See "Texturing & Modeling, A Procedural Approach", Chapter 12
float ridge(float h, float offset) {
  h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  h = h * h;      // sharpen creases
  return h;
}

float ridgedMF(vec2 p, float u_t) {
  float lacunarity = 5.0;
  float gain = 0.1;
  float offset = 0.9;

  float sum = 0.0;
  float freq = 3.0, amp = 4.5;
  float prev = 1.0;
  float move_time = sin(u_t * 0.14 + u_t);

  for(int i=0; i < OCTAVES; i++) {
    // float n = ridge(snoise(p*freq * tan( 0.05 * u_t + sin(u_t))), offset);
    // float n = ridge(snoise(p*freq * tan( 1.05 *  sin(u_t))), offset);
    float n = ridge(snoise(p*freq * fract( 1.05 *  atan(0.5 * u_t))), offset + move_time);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}

vec3 ridge_main(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(0.0);

  audio.highpass *= 100.0;
  audio.lowpass *= 100.0;
  audio.bandpass *= 100.0;
  audio.notch *= 100.0;

  if (audio.bandpass > 1.0) {
    color += ridgedMF(pos *6.0, audio.bandpass); 
  }

  float time_limit = 20.0;
  float time_segment = 4.0;
  float mod_time = mod(u_time, time_limit);

  if (mod_time < time_segment * 1.0) {
    color = vec3(0.8, color.y, color.x * abs(sin(u_time)));

  } else if (mod_time < time_segment * 1.0) {
    color = vec3(0.8, color.x, 0.4 * abs(sin(u_time)));

  } else if (mod_time < time_segment * 2.0) {
    color = vec3(color.x - 0.1, 0.7, color.y * abs(sin(u_time)));

  } else if (mod_time < time_segment * 3.0) {
    color = vec3(color.x - 0.3, 0.3, color.y * abs(sin(u_time)));

  } else if (mod_time < time_segment * 4.0) {
    color = vec3(color.y, color.x + 0.3, 0.8 * abs(sin(u_time)));
  }

  return color;
}
#endif
