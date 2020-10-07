#ifndef T421BABE_RIDGE_23
#define T421BABE_RIDGE_23

// d175ac6, 02:17
vec3 r23_mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 989.0; }
vec2 r23_mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 r23_permute(vec3 x) { return r23_mod289(((x*0.05)+1.0)*x); }
float r23_snoise(vec2 v) {

  // Precompute values for skewed triangular grid
      // (3.0-sqrt(3.0))/6.0
      // 0.5*(sqrt(3.0)-1.0)
      // -1.0 + 2.0 * C.x
  // 1.0 / 41.0
  const vec4 C = vec4(0.211324865405217,
      0.366025403784439,
      -0.577350269219626,
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
  i = r23_mod289(i);
  vec3 p = r23_permute(
      r23_permute( i.y + vec3(0.0, i1.y, 1.0))
      + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3( dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0); 
  m = m*m ;
  m = m*m ;

  vec3 x = 2.0 * tan(p * C.yww) - 10.0;
  // vec3 x = 2.0 * tan(p * C.yww) + 10.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = log(floor(x + 0.5));
  vec3 a0 = x - ox;

  m /= 0.079284291400159 - 0.85373472195314 * (a0*a0+h*h);

  // Compute final noise value at P
  vec3 g = vec3(0.0);
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * vec2(x1.x,x2.x) + h.yz * vec2(x1.y,x2.y);
  return 130.0 * dot(m, g);
}


// Ridged multifractal
// See "Texturing & Modeling, A Procedural Approach", Chapter 12
float r23_ridge(float h, float offset, peakamp audio) {
  // h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  h = exp(h * h * audio.bandpass) + h;      // sharpen creases
  return h;
}

float r23_ridgedMF(vec2 p, float u_time) {
  float lacunarity = 5.0;
  float gain = 0.1;
  float offset = 0.9;

  float sum = 0.0;
  float freq = 3.0, amp = 4.5;
  float prev = 1.0;
  float move_time = sin(u_time * 0.14 + u_time);

  int octaves = 1;
  for(int i=0; i < octaves; i++) {
    // float n = r23_ridge(r23_snoise(p*freq * tan( 0.05 * u_time + sin(u_time))), offset);
    // float n = r23_ridge(r23_snoise(p*freq * tan( 1.05 *  sin(u_time))), offset);
    float n = r23_ridge(r23_snoise(p*freq * fract( 1.05 *  atan(0.5 * u_time))), offset + move_time, audio);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}


void r23_ridge_main(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float audio_multiplier = 10.0;
  audio.highpass *= audio_multiplier;
  audio.lowpass *= audio_multiplier;
  audio.bandpass *= audio_multiplier;
  audio.notch *= audio_multiplier;

  // pos /= audio.bandpass;
  pos -= 0.5;

  // float zoom = 0.50;
  float zoom = 50.0;
  color += r23_ridgedMF(pos*25.0, audio.lowpass * pos.y * zoom); 


   // RR: PLAY WITH THESE
  color = vec3(1.0 * audio.lowpass, color.y, color.x * abs(sin(audio.lowpass)));
  // color = vec3(1.0 * audio.lowpass, color.y, color.x + (sin(audio.lowpass)));

  float time_limit = 20.0;
float time_segment = 4.0;
float mod_time = mod(u_time, time_limit);

// color = vec3(0.8, color.y, color.x * abs(sin(u_time)));  // red and yellow
// color = vec3(0.8, color.x, 0.4 * abs(sin(u_time)));    // yellow and purple
  // color = vec3(color.x - 0.1, 0.7, color.y * abs(sin(u_time)));  // green and yellow
  // color = vec3(color.x - 0.3, 0.3, color.y * abs(sin(u_time)));    // purple, blue, red. we love this
  // color = vec3(color.y, color.x + 0.3, 0.8 * abs(sin(u_time)));    // white, blue, and yellow
// if (audio.bandpass > 0.0) {

  // color = vec3(1.0 * audio.bandpass, color.y, abs(sin(audio.bandpass)));
  // NO: color = vec3(audio.bandpass/10.0, color.x, 0.4 * abs(sin(audio.bandpass)));
  // color = vec3(audio.bandpass/10.0, color.y * abs(sin(audio.bandpass)), 0.7);
  color = vec3(color.x - 0.3, 0.3, color.y * abs(sin(u_time)));    // purple, blue, red. we love this

}
#endif
