#ifndef T420BABE_WITHDRAWLS_13
#define T420BABE_WITHDRAWLS_13

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef BOS_TURBULENCE
#include "./lib/bos/turbulence.glsl"
#endif

#ifndef CLOUDS
#include "./lib/bos/clouds.glsl"
#endif

vec2 tile(vec2 _pos, float _zoom){
  _pos *= _zoom;
  return fract(_pos);
}

float jail(vec2 _pos, float _radius){
  vec2 pos = vec2(0.5)-_pos;
  _radius *= 5.75 * abs(audio.highpass);
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), fract(pos.x * pos.y) * 0.05 * (abs(sin(u_time * 0.1)) + 0.1));
  // return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), fract(pos.x * pos.y) * 3.14 * (abs(sin(u_time * 2.5)) +1.0));
}

float circle(vec2 pos, float _radius){
  _radius *= 0.75;
  return 1.0 - smoothstep( _radius - (_radius * 0.05), _radius + (_radius * 0.05), dot(pos, pos) * 3.14 );
}

float rectangle(in vec2 pos, in vec2 origin, in vec2 dim) {
  vec2 aa = origin - dim / 2.0;
  vec2 bb = 1.0 - (origin + dim / 2.0);

  vec2 onblock = step(aa, pos);
  vec2 offblock = step(bb, 1.0 - pos);
  return onblock.x * onblock.y * offblock.x * offblock.y;
}

void withdrawls_13(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  vec2 pos_0 = tile(pos, 10.0);

  color = vec3(jail(pos_0, 1.0));
  vec2 origin = vec2(0.0);
  vec2 dim = vec2(1.0);
  dim += audio.lowpass;
  vec3 rect_color = vec3(1.0 - rectangle(pos, origin, dim));;
  vec3 clouds_color = vec3(1.0);
  clouds(pos, u_time, audio, color);

  color.r *= abs(audio.bandpass) * 1.5;
  color.b *= abs(sin(u_time * 0.5));
  // color /= vec3(circle(pos * vec2(sin(u_time * 0.2)), 1.0));
  // color.g *= abs(audio.notch) * 1.0;
}

#endif
