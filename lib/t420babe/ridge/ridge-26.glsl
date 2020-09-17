#ifndef T420BABE_RIDGE_26
#define T420BABE_RIDGE_26
// c306818, 02:25
vec3 r26_mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 989.0; }
vec2 r26_mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 r26_permute(vec3 x) { return r26_mod289(((x*0.05)+1.0)*x); }
float r26_snoise(vec2 v) {

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
  vec2 i  = floor(v + dot(v, C.yy));
  vec2 x0 = v - i + dot(i, C.xx);

  // Other two corners (x1, x2)
  vec2 i1 = vec2(0.0);
  i1 = (x0.x > x0.y)? vec2(1.0, 0.0):vec2(0.0, 1.0);
  vec2 x1 = x0.xy + C.xx - i1;
  vec2 x2 = x0.xy + C.zz;

  // Do some permutations to avoid
  // truncation effects in permutation
  i = r26_mod289(i);
  vec3 p = r26_permute(
      r26_permute( i.y + vec3(0.0, i1.y, 1.0))
      + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3( dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0); 
  m = m*m ;
  m = m*m ;

  vec3 x = 2.0 * tan(p * C.yww) + 10.0;
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
float r26_ridge(float h, float offset) {
  h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  // h = h * h;      // sharpen creases
  return h;
}

float r26_ridgedMF(vec2 p, float u_time) {
  float lacunarity = 5.0;
  float gain = 0.1;
  float offset = 0.9;

  float sum = 0.0;
  float freq = 3.0, amp = 4.5;
  float prev = 1.0;
  float move_time = sin(u_time * 0.14 + u_time);

  int octaves = 2;
  for(int i=0; i < octaves; i++) {
    // float n = r26_ridge(r26_snoise(p*freq * tan( 0.05 * u_time + sin(u_time))), offset);
    // float n = r26_ridge(r26_snoise(p*freq * tan( 1.05 *  sin(u_time))), offset);
    float n = r26_ridge(r26_snoise(p*freq * fract( 1.05 *  atan(0.5 * u_time))), offset + move_time);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}


void r26_ridge_main(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float audio_multiplier = 10.0;
  audio.highpass *= audio_multiplier;
  audio.lowpass *= audio_multiplier;
  audio.bandpass *= audio_multiplier;
  audio.notch *= audio_multiplier;

	pos = square_position(pos);
  pos /= audio.bandpass + 2.0;
  pos.y += 0.5;

  float zoom = 0.05;
  // color += r26_ridgedMF(pos*25.0, audio.lowpass * pos.y * zoom);
  color += r26_ridgedMF(pos*25.0, audio.lowpass * pos.y * 50.0);  // 500.0?


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
