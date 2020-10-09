#ifndef T420BABE_ALLIGATOR
#define T420BABE_ALLIGATOR

// Inspiration and original functions by @patriciogv - 2015, Tittle: Ridge
vec3 alligator_mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 989.0; }
vec2 alligator_mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 alligator_permute(vec3 x) { return alligator_mod289(((x * 0.05) + 1.0) * x); }

float alligator_snoise(vec2 v) {

  // Precompute values for skewed triangular grid
  // (3.0-sqrt(3.0))/6.0, 0.5*(sqrt(3.0)-1.0), -1.0 + 2.0 * C.x, 1.0 / 41.0)
  const vec4 C = vec4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);

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
  i = alligator_mod289(i);
  vec3 p = alligator_permute(alligator_permute( i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3( dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0);

  m = m * m;
  m = m * m;

  // Gradients: 41 pts uniformly over a line, mapped onto a diamond
  //  The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = log(floor(x + 0.5));
  vec3 a0 = x - ox;

  // Normalise gradients implicitly by scaling m
  // Approximation of: m *= inversesqrt(a0*a0 + h*h);
  m /= 0.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);

  // Compute final noise value at P
  vec3 g = vec3(0.0);
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * vec2(x1.x,x2.x) + h.yz * vec2(x1.y,x2.y);
  return 130.0 * dot(m, g);
}


// Ridged multifractal
// See "Texturing & Modeling, A Procedural Approach", Chapter 12
float alligator_ridge_alligator(float h, float offset) {
  h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  h = h * h;      // sharpen creases
  return h;
}

float alligator_ridgedMF(vec2 p, float u_time, peakamp audio) {
  float lacunarity = 5.0;
  float gain = 0.1;
  float offset = 0.9;

  float sum = 0.0;
  float freq = 3.0;
  float amp = 4.5;
  float prev = 1.0;
  float move_time = sin(u_time * 0.14 + u_time);


  int octaves = 25;
  for(int i=0; i < octaves; i++) {
    // float n = alligator_ridge_alligator(alligator_snoise(p*freq * tan( 0.05 * u_time + sin(u_time))), offset);
    // float n = alligator_ridge_alligator(alligator_snoise(p*freq * tan( 1.05 *  sin(u_time))), offset);
    // float n = alligator_ridge_alligator(alligator_snoise(p*freq * fract( 1.05 *  atan(0.5 * u_time))), offset + move_time);
    float n = alligator_ridge_alligator(alligator_snoise( p * freq * 0.1 * atan( u_time * 0.5   )), offset + move_time);
    // float n = alligator_ridge_alligator(alligator_snoise(p*freq), offset + move_time);
    // RR YES:
    // float n = alligator_ridge_alligator(alligator_snoise(p*freq * ( 1.05 *  sin(0.5 * u_time))), offset + move_time);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}


void alligator(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= 2.0;

  audio.highpass *= 100.0;
  audio.lowpass *= 100.0;
  audio.bandpass *= 100.0;
  audio.notch *= 100.0;

  color += alligator_ridgedMF(pos * 20.0, audio.bandpass * pos.x, audio); 

  color = vec3(color.r - 0.87324, color.b - 0.3, color.g * abs(sin(u_time)));
}
#endif
