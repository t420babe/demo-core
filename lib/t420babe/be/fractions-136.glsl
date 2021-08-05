#ifndef T4B_FRACTIONS_136
#define T4B_FRACTIONS_136

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

float rectangle(in vec2 pos, in vec2 origin, in vec2 dim) {
  vec2 aa = origin - dim / 2.0;
  vec2 bb = 1.0 - (origin + dim / 2.0);

  vec2 onblock = step(aa, pos);
  vec2 offblock = step(bb, 1.0 - pos);
  return onblock.x * onblock.y * offblock.x * offblock.y;
}

void fractions_136(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  // float bri = step(abs(tan( audio.notch * p3.x * 10. + t) * 0.3 + p3.x * sin(t)), 0.01);

  // p3 *= 5.0;
  // Center point
  // float p_c = (sin(time)) * 0.5;
  float p_c = 0.0;
  float thickness = 0.01;
  float bri = step(abs(p3.x + p_c), thickness);
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);

  gl_FragColor = vec4(color * 2.0, bri);
  float len_trail = 0.001;
  vec2 p_offset = vec2(0.001, 0.01);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/2.+ 0.51) + p_offset) - len_trail;
}
#endif

