#ifndef T420BABE_RIDGE
// Author: @patriciogv - 2015
// Tittle: Ridge

// Some useful functions
// vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
// vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
// vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 989.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*0.05)+1.0)*x); }

//
// Description : GLSL 2D simplex noise function
//      Author : Ian McEwan, Ashima Arts
//  Maintainer : ijm
//     Lastmod : 20110822 (ijm)
//     License :
//  Copyright (C) 2011 Ashima Arts. All rights reserved.
//  Distributed under the MIT License. See LICENSE file.
//  https://github.com/ashima/webgl-noise
//
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

#define OCTAVES 1

// Ridged multifractal
// See "Texturing & Modeling, A Procedural Approach", Chapter 12
float ridge(float h, float offset, float full_ave) {
  h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  h = exp(h * h * full_ave) + h;      // sharpen creases
  return h;
}

float ridgedMF(vec2 p, float u_t, float full_ave) {
  float lacunarity = 1.0;
  float gain = 1.1;
  float offset = 10.9;

  float sum = 4.0;
  float freq = 3.0, amp = 4.5;
  float prev = 1.0;
  float move_time = sin(u_t * 0.14 + u_t);

  for(int i=0; i < OCTAVES; i++) {
    // float n = ridge(snoise(p*freq * tan( 0.05 * u_t + sin(u_t))), offset);
    // float n = ridge(snoise(p*freq * tan( 1.05 *  sin(u_t))), offset);
    float n = ridge(snoise(p*freq * fract( 1.05 *  atan(0.5 * u_t))), offset + move_time, full_ave);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}

vec3 ridge_main(vec4 frag_coord, vec2 u_r, float u_t, float full_ave, float full_max) {
  vec2 st = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  st.y *= u_r.y / u_r.x; // fix resolution x-axis stretching
  // st /= 53.0;
  st /= full_ave * 2.0;
  st -= 1.0;
  // st += full_ave;
  // vec2 st = frag_coord.xy/u_r.xy;
  // st.x *= u_r.x/u_r.y;
  vec3 color = vec3(0.0);

  // if (full_max > 10.0) {
    // color += ridgedMF(st*6.0, clamp(full_max, 10.0, 200.0));
  color += ridgedMF(st*25.0, full_max * st.y * 50.0, full_ave); 
  // }

  float time_limit = 20.0;
  float time_segment = 4.0;
  float mod_time = mod(u_t, time_limit);

  // color = vec3(0.8, color.y, color.x * abs(sin(u_t)));  // red and yellow
  // color = vec3(0.8, color.x, 0.4 * abs(sin(u_t)));    // yellow and purple
    // color = vec3(color.x - 0.1, 0.7, color.y * abs(sin(u_t)));  // green and yellow
    // color = vec3(color.x - 0.3, 0.3, color.y * abs(sin(u_t)));    // purple, blue, red. we love this
    // color = vec3(color.y, color.x + 0.3, 0.8 * abs(sin(u_t)));    // white, blue, and yellow
  // if (full_max > 0.0) {
  if (mod_time < time_segment * 1.0) {
    color = vec3(1.0 * full_min, color.y, color.x * abs(sin(full_max)));

  } else if (mod_time < time_segment * 1.0) {
    color = vec3(full_ave/10.0, color.x, 0.4 * abs(sin(full_max)));

  } else if (mod_time < time_segment * 2.0) {
    color = vec3(full_ave/10.0, color.y * abs(sin(full_max)), 0.7);

  } else if (mod_time < time_segment * 3.0) {
    // color = vec3(full_ave / 10.0, 0.3, color.y * abs(sin(full_max)));
    color = vec3(color.x - 0.3, 0.3, color.y * abs(sin(u_t)));    // purple, blue, red. we love this

  } else if (mod_time < time_segment * 4.0) {
    color = vec3(full_ave / 10.0, color.x + 0.3, 0.8 * abs(sin(full_max)));
  }
  // }

  return color;
  // gl_FragColor = vec4(color,1.0);
}
#endif
