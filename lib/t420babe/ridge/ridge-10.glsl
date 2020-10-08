#ifndef T420BABE_RIDGE_10
#define T420BABE_RIDGE_10
// 3c76edd, 01:35
vec3 r10_mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 989.0; }
vec2 r10_mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 r10_permute(vec3 x) { return r10_mod289(((x*0.05)+1.0)*x); }
float r10_snoise(vec2 v) {

  // Precompute values for skewed triangular grid
      // (3.0-sqrt(3.0))/6.0
      // 0.5*(sqrt(3.0)-1.0)
      // -1.0 + 2.0 * C.x
  // 1.0 / 41.0
  const vec4 C = vec4(0.211324865405187,
      0.366025403784439,
      -0.577350269189626,
      0.024390243902439);

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
  i = r10_mod289(i);
  vec3 p = r10_permute(
      r10_permute( i.y + vec3(0.0, i1.y, 1.0))
      + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3( dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0); 
  m = m*m ;
  m = m*m ;

  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = log(floor(x + 0.5));
  vec3 a0 = x - ox;

  m /= 0.079284291400159 - 0.85373472095314 * (a0*a0+h*h);

  // Compute final noise value at P
  vec3 g = vec3(0.0);
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * vec2(x1.x,x2.x) + h.yz * vec2(x1.y,x2.y);
  return 130.0 * dot(m, g);
}


// Ridged multifractal
// See "Texturing & Modeling, A Procedural Approach", Chapter 12
float r10_ridge(float h, float offset) {
  h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  h = h * h;      // sharpen creases
  return h;
}

float r10_ridgedMF(vec2 p, float u_time) {
  float lacunarity = 5.0;
  float gain = 0.1;
  float offset = 0.9;

  float sum = 0.0;
  float freq = 3.0, amp = 4.5;
  float prev = 1.0;
  float move_time = sin(u_time * 0.14 + u_time);

  int octaves = 25;
  for(int i=0; i < octaves; i++) {
    // float n = r10_ridge(r10_snoise(p*freq * tan( 0.05 * u_time + sin(u_time))), offset);
    // float n = r10_ridge(r10_snoise(p*freq * tan( 1.05 *  sin(u_time))), offset);
    float n = r10_ridge(r10_snoise(p*freq * fract( 1.05 *  atan(0.5 * u_time))), offset + move_time);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}


void r10_ridge_main(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  audio.highpass *= 100.0;
  audio.lowpass *= 100.0;
  audio.bandpass *= 100.0;
  audio.notch *= 100.0;

  pos /= 53.0;
  pos += 0.5;

  color += r10_ridgedMF(pos*11.0, audio.bandpass * pos.x); 

  float time_limit = 20.0;
  float time_segment = 4.0;
  float mod_time = mod(u_time, time_limit);


 // color = vec3(0.8, color.y, color.x * abs(sin(u_time)));  // red and yellow
 // color = vec3(0.8, color.x, 0.4 * abs(sin(u_time)));    // yellow and purple
   // color = vec3(color.x - 0.1, 0.7, color.y * abs(sin(u_time)));  // green and yellow
   // color = vec3(color.x - 0.3, 0.3, color.y * abs(sin(u_time)));    // purple, blue, red. we love this
   // color = vec3(color.y, color.x + 0.3, 0.8 * abs(sin(u_time)));    // white, blue, and yellow
 if (mod_time < time_segment * 1.0) {
   color = vec3(0.8, color.y, color.x * abs(sin(u_time)));

 } else if (mod_time < time_segment * 1.0) {
   color = vec3(0.8, color.x, 0.4 * abs(sin(u_time)));

 } else if (mod_time < time_segment * 2.0) {
   color = vec3(color.x - 0.1, color.y * abs(sin(u_time)), 0.7);

 } else if (mod_time < time_segment * 3.0) {
   color = vec3(color.x - 0.3, 0.3, color.y * abs(sin(u_time)));

 } else if (mod_time < time_segment * 4.0) {
   color = vec3(color.y, color.x + 0.3, 0.8 * abs(sin(u_time)));
 }


}
#endif
