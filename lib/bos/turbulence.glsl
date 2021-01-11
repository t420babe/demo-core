#ifndef BOS_TURBULENCE
#define BOS_TURBULENCE

#ifndef COMMON_PERMUTE
#include "./lib/common/permute.glsl" 
#endif


#ifndef COMMON_WRAP_TIME
float wrap_time(float u_time, float limit) {
  limit *= 2.0;
  float mod_time = mod(u_time, limit);
  if (mod_time < limit / 2.0) {
    return mod_time;
  } else {
    return limit - mod_time;
  }
}
#endif

#ifndef COMMON_NOISE
float turbulence_snoise(vec2 v, peakamp audio) {
  // (3.0-sqrt(3.0))/6.0, 0.5*(sqrt(3.0)-1.0), -1.0 + 2.0 * C.x, 1.0 / 41.0
  // const vec4 C = vec4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);
  const vec4 C = vec4(0.211324865405187, 0.066025403784439, 0.077350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 )) + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}
#endif

float turbulence (in vec2 st, float u_time, peakamp audio) {
    // Initial values
    float value = 0.0;
    float amplitude = 2.5 * audio.bandpass;
    float frequency = audio.bandpass;
    //
    // Loop of octaves
    int octaves = 3;
    for (int i = 0; i < 3; i++) {
        value += amplitude * fract(abs(turbulence_snoise(st, audio)));
        st *= 20.;
        amplitude *= .5 * wrap_time(u_time, 3.0) - 1.0;
    }
    return value;
}

void turbulence(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
    // color = vec3(0.0);

    color.r += turbulence(pos * 3.0, u_time, audio);
    color.r += turbulence(pos * 3.0, u_time, audio);
    color.b /= turbulence(pos * 3.0, u_time, audio);
}

#endif
