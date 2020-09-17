#ifndef T420BABE_RIDGE_27
#define T420BABE_RIDGE_27
// c306818, 02:25
vec3 r27_mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 989.0; }
vec2 r27_mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 r27_permute(vec3 x) { return r27_mod289(((x*0.05)+1.0)*x); }
float r27_snoise(vec2 v) {

  // Precompute values for skewed triangular grid
      // (3.0-sqrt(3.0))/6.0
      // 0.5*(sqrt(3.0)-1.0)
      // -1.0 + 2.0 * C.x
  // 1.0 / 41.0
  const vec4 C = vec4(0.211324865405197,
      0.366025403784439,
      -0.577350269199626,
      0.024390243902439);

  // First corner (x0)
  vec2 i  = floor(v + dot(v, C.zy));
  vec2 x0 = v - i + dot(i, C.zx);

  // Other two corners (x1, x2)
  vec2 i1 = vec2(0.0);
  i1 = (x0.x > x0.y)? vec2(1.0, 0.0):vec2(0.0, 1.0);
  vec2 x1 = x0.xy + C.xx - i1;
  vec2 x2 = x0.xy + C.zz;

  // Do some permutations to avoid
  // truncation effects in permutation
  i = r27_mod289(i);
  vec3 p = r27_permute(
      r27_permute( i.y + vec3(0.0, i1.y, 1.0))
      + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3( dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0); 
  m = m*m ;
  m = m*m ;

  vec3 x = 2.0 * tan(p * C.wwz) - 10.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = log(floor(x + 0.5));
  vec3 a0 = x - ox;

  m /= 0.079284291400159 - 0.85373472095314 * (a0*a0+h*h);

  // Compute final noise value at P
  vec3 g = vec3(0.0);
  g.x  = a0.y  * x0.y  + h.x  * x0.x;
  g.yz = a0.yz * vec2(x1.x,x2.y) + h.yz * vec2(x1.y,x2.y);
  return 130.0 * dot(m, g);
}


// Ridged multifractal
// See "Texturing & Modeling, A Procedural Approach", Chapter 12
float r27_ridge(float h, float offset) {
  h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  h = exp(h * h ) + h;
  // h = h * h;      // sharpen creases
  return h;
}

float r27_ridgedMF(vec2 p, float u_time) {
  float lacunarity = 1.0;
  float gain = 1.1;
  float offset = 10.9;

  float sum = 4.0;
  float freq = 3.0, amp = 4.5;
  float prev = 1.0;
  float move_time = sin(u_time * 0.14 + u_time);

  int octaves = 2;
  for(int i=0; i < octaves; i++) {
    // float n = r27_ridge(r27_snoise(p*freq * tan( 0.05 * u_time + sin(u_time))), offset);
    // float n = r27_ridge(r27_snoise(p*freq * tan( 1.05 *  sin(u_time))), offset);
    float n = r27_ridge(r27_snoise(p*freq * fract( 1.05 *  atan(0.5 * u_time))), offset + move_time);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}


void r27_ridge_main(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float audio_multiplier = 10.0;
  audio.highpass *= audio_multiplier;
  audio.lowpass *= audio_multiplier;
  audio.bandpass *= audio_multiplier;
  audio.notch *= audio_multiplier;

	pos = square_position(pos);
  pos /= audio.bandpass + 2.0;
  pos.y += 0.5;

  float zoom = 0.05;
  // color += r27_ridgedMF(pos*25.0, audio.lowpass * pos.y * zoom);
  color += r27_ridgedMF(pos*25.0, audio.lowpass * pos.y * 50.0);  // 500.0?


   // RR RIGHT HERE: PLAY WITH THESE
   // Bassically by Tei Shi
   color = vec3(audio.lowpass * color.r, audio.lowpass * color.g, audio.lowpass * color.b);
   color.g = 1.0 - color.g;
   // color = vec3(audio.lowpass * color.r, color.g, audio.lowpass * color.b);   // purple & yellow
   // color = vec3(color.r, audio.lowpass * color.g, audio.lowpass * color.b);
   // color = vec3(audio.lowpass * color.r, audio.lowpass * color.g, color.b);

   color += 0.05;
}
#endif
