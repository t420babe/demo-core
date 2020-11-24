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
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), sin(pos.x * pos.x) * 3.14);
}

float circle(vec2 pos, float _radius){
  _radius *= 0.75;
  return 1.-smoothstep(_radius-(_radius*0.05),_radius+(_radius*0.05),dot(pos,pos)*3.14);
}

float rays_audio(vec2 st, float N, peakamp audio) {
    st.y += 0.0;
    // st.x +=1.2;
    return log(atan(st.x, st.x) * audio.notch * 1.01 / TWO_PI * N);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  audio.lowpass *= 2.0;
  audio.highpass *= 2.0;
  audio.bandpass *= 2.0;
  audio.notch *= 2.0;
  vec3 color = vec3(1.0);

  vec2 st = tile(pos,10.);
  color = vec3(jail(st, 5.2));
  color /= vec3(circle(pos, 7.0 * abs(audio.notch)));
  color /= rays_audio(pos, 20.0, audio);

  color.r += abs(audio.bandpass) * 2.0;
  color.g *= abs(audio.notch) * 2.0;
  color.b *= abs(audio.bandpass) * 2.0;

  gl_FragColor = vec4(color, 1.0);
}
