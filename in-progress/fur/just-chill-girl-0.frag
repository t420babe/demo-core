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

float jail(vec2 _pos, float _radius){
  vec2 pos = vec2(0.5) - _pos;
  _radius *= 5.75 * abs(audio.highpass);
  // float mul_0 = abs(audio.notch);
  // float mul_1 = 0.5;
  float mul_0 = abs(sin(u_time));
  float mul_1 = abs(cos(u_time));
  return 1.0 - smoothstep(1.0 - (_radius * mul_0), _radius + (_radius * mul_1), dot(tan(pos), pos) * 1.14);
}

float circle(vec2 pos, float _radius){
  _radius *= 0.35;
  float mul_0 = abs(sin(u_time));
  float mul_1 = abs(cos(u_time));
  return 1.0 - smoothstep(_radius - (_radius * mul_0), _radius + (_radius * mul_1), dot(pos, pos) * 4.14);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  vec2 st = tile(pos, 5.0);
  color = vec3(jail(st, 5.2));
  color /= vec3(circle(pos, 7.0 * abs(audio.notch)));

  color.r /= abs(audio.bandpass) * 0.5;
  color.g = abs(audio.notch);
  // color.b *= abs(audio.bandpass) * 0.0;
	
  // color.r += abs(sin(u_time));

  gl_FragColor = vec4(color, 1.0);
}







