#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef BOS_TURBULENCE
#include "./lib/bos/turbulence.glsl"
#endif

#ifndef CLOUDS
#include "./lib/bos/clouds.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

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

float rays_audio(vec2 st, int N, peakamp audio) {
    st.y -= 0.7;
    // st.x +=1.2;
    return log(atan(st.x, st.x) * audio.notch * 1.01 /TWO_PI*float(N));
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  vec2 pos_0 = tile(pos, 10.0);

  color = vec3(jail(pos_0, 1.0));
  // color -= vec3(circle(pos, 4.0 * abs(audio.notch)));
  vec2 origin = vec2(0.0);
  vec2 dim = vec2(1.5, 1.5);
  dim += audio.lowpass;
  vec3 rect_color = vec3(1.0 - rectangle(pos, origin, dim));;
  float ray = rays_audio(pos, 4, audio);
  vec3 clouds_color = vec3(1.0);
  clouds(pos, u_time, audio, clouds_color);
  color /= clouds_color - vec3(0.0);
  color -= (rectangle(pos, origin, dim) - 0.0);
  color -= (ray);
  // color.b += abs(sin(u_time * 0.5));
  // color /= turbulence(pos.yy * 10.0, u_time, audio);
  // color += clouds_color;
  // color.r += abs(cos(u_time * 0.5));
  // rect_color.r -= 0.4;
  // color /= rect_color;
  // vec2 pos_1 = pos - vec2(0.0);
  // color *= vec3(1.0 - circle(pos_1, 4.0 * abs(audio.highpass)));

  // color.g += abs(audio.bandpass) * 1.5;
  color.b += abs(audio.notch) * 0.5;
  color.g *= abs(audio.notch) * 2.0;

  gl_FragColor = vec4(color, 1.0);
}

