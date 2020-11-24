// Spa - Sofi Tukker, Icona Pop
#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 tile(vec2 _st, float _zoom){
  _st *= _zoom;
  return fract(_st);
}

float jail(vec2 _st, float _radius){
  vec2 pos = vec2(0.5)-_st;
  _radius *= 5.75 * abs(audio.highpass);
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), tan(pos.x * pos.x) * 3.14);
}

float circle(vec2 pos, float _radius){
  _radius *= 0.75;
  float mul_0 = -abs(sin(u_time * 3.6)) * 2.0;
  if (abs(audio.notch) > 0.7) {
    mul_0 = -1.0;
  }
  float mul_1 = mul_0;
  return 1.0 - smoothstep(_radius - (_radius * mul_0), _radius + (_radius * mul_1), (dot(pos, pos)) * 3.14);
}

float rectangle(in vec2 pos, in vec2 origin, in vec2 dim) {
  vec2 aa = origin - dim / 2.0;
  vec2 bb = 1.0 - (origin + dim / 2.0);

  vec2 onblock = step(aa, pos);
  vec2 offblock = step(bb, 1.0 - pos);
  return onblock.x * onblock.y * offblock.x * offblock.y;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  vec2 st = tile(pos,10.);
  color *= vec3(jail(st, 5.2));
  color /= vec3(circle(pos, 7.0 * abs(audio.notch)));
  vec2 origin = vec2(0.0);
  vec2 dim = vec2(2.5);
  dim *= abs(audio.lowpass);
  color.r /= rectangle(pos, origin, dim);

  color.b *= abs(audio.bandpass) * 1.0;
  // color.g *= abs(audio.notch) * 2.0;
  color.g *= abs(audio.bandpass) * 2.0;
  color.r -= abs(audio.lowpass) * 2.5;
  // color.r *= abs(sin(u_time * audio.highpass));

  gl_FragColor = vec4(color, 1.0);
}
