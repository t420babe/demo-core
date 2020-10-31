#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef BOS_TURBULENCE
#include "./lib/bos/turbulence.glsl"
#endif


#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float lineJitter = 0.5;
float lineWidth = 7.0;
float gridWidth = 1.7;
float scale = 0.0013;
float zoom = 2.0;
vec2 offset = vec2(0.5);

float rand (in float _x) {
  return fract(sin(_x)*1e4);
}

float rand (in vec2 co) {
  return fract(sin(dot(co.xy,vec2(12.9898,78.233)))*43758.5453);
}

float turbulence_noise (in float _x) {
  float i = floor(_x);
  float f = fract(_x);
  float u = f * f * (3.0 - 2.0 * f);
  return mix(rand(i), rand(i + 1.0), u);
}

float turbulence_noise (in vec2 _st) {
  vec2 i = floor(_st);
  vec2 f = fract(_st);
  // Four corners in 2D of a tile
  float a = rand(i);
  float b = rand(i + vec2(1.0, 0.0));
  float c = rand(i + vec2(0.0, 1.0));
  float d = rand(i + vec2(1.0, 1.0));
  vec2 u = f * f * (3.0 - 2.0 * f);
  return mix(a, b, u.x) + 
    (c - a)* u.y * (1.0 - u.x) + 
    (d - b) * u.x * u.y;
}

float wave_signal(vec2 _pos, float amplitude, float frequency, float phase, float audio_signal) {
  audio_signal = abs(audio_signal);
  float y = amplitude * sin(_pos.x * frequency);
  float t = 0.012 * (u_time * 120.0);
  // float t = 1.00 * (mod(u_time, audio_signal));
  y += fract(_pos.x * frequency * 1.0 + t * audio_signal * 120.0) * 20.0 + phase;
  y *= amplitude * 0.06;
  return y;
}

float wave(vec2 _pos, float amplitude, float frequency, float phase, float audio_signal) {
  audio_signal = abs(audio_signal);
  float y = amplitude * sin(_pos.x * frequency);
  float t = 0.012 * (u_time * 120.0);
  // float t = 1.00 * (mod(u_time, audio_signal));
  y += sin(_pos.x * frequency * 2.0 + t * audio_signal * 120.0) * 5.0 + phase;
  y *= amplitude * 0.06;
  return y;
}

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(0.0);
  // vec2 st = (gl_FragCoord.xy/u_resolution.xy)-offset;
  // st.x *= u_resolution.x/u_resolution.y;

  // scale *= zoom;
  // color += plot(pos, 0.55) * vec3(1.0);
  // color += plot(pos, 0.0) * vec3(1.0);
  // color += plot(pos, -0.55) * vec3(1.0);
  pos = pos.yx;
  // pos = pos.xx;
  pos *= zoom;
  
  float amplitude = 0.5;
  float frequency = 2.0;

  float h_phase = -25.0;
  float h_y = wave(pos, amplitude, frequency, h_phase, audio.highpass);
  float h_pct = plot(pos, h_y);

  float l_phase = 25.0;
  float l_y = wave(pos, amplitude, frequency, l_phase, audio.lowpass);
  float l_pct = plot(pos, l_y);

  float b_phase = 9.0;
  float b_y = wave(pos, amplitude, frequency, b_phase, audio.bandpass);
  float b_pct = plot(pos, b_y);

  float n_phase = -9.0;
  float n_y = wave(pos, amplitude, frequency, n_phase, audio.notch);
  float n_pct = plot(pos, n_y);

  float sum_audio = audio.highpass + audio.lowpass + audio.bandpass + audio.notch;
  float sum_audio_phase_left = -80.0;
  float sum_audio_y_left = wave_signal(pos, amplitude, frequency, sum_audio_phase_left, sum_audio);
  float sum_audio_pct_left = plot(pos, sum_audio_y_left);

  float sum_audio_phase_right = 65.0;
  float sum_audio_y_right = wave_signal(pos, amplitude, frequency, sum_audio_phase_right, sum_audio);
  float sum_audio_pct_right = plot(pos, sum_audio_y_right);

  float sum_signal = (h_y + l_y + b_y + n_y) * 1.5;
  float sum_signal_upper = sum_signal + 2.5;
  float sum_signal_lower = sum_signal - 2.5;
  float pct = plot(pos, sum_signal);
  float pct_upper = plot(pos, sum_signal_upper);
  float pct_lower = plot(pos, sum_signal_lower);

  color += l_pct * vec3(0.0, 1.0, 1.0);
  color += b_pct * vec3(1.0, 1.0, 0.0);
  color += n_pct * vec3(0.5, 0.0, 1.0);
  color += h_pct * vec3(1.0, 0.0, 1.0);

  // color += pct_upper * vec3(1.0, 1.0, 1.0);
  // color += pct_lower * vec3(1.0, 1.0, 1.0);
  color += sum_audio_pct_left * vec3(1.0, 1.0, 1.0);
  color += sum_audio_pct_right * vec3(1.0, 1.0, 1.0);
  // color += plot(pos, 0.0) * vec3(1.0);
  // color += plot(pos, 0.5) * vec3(1.0);
  // color += plot(pos, -0.5) * vec3(1.0);
  // color += plot(pos, -1.0) * vec3(1.0);
  // color += plot(pos, 1.0) * vec3(1.0);
  // color += pct * vec3(audio.highpass, abs(tan(u_time + audio.notch)), abs(sin(u_time)));
  // color = 1.0 - color;

  // color = vec3(0.24323 * audio.notch, 0.93254 * audio.highpass * 0.5, 0.89795);
  vec3 circle_color = vec3(0.0);
  turbulence(pos, u_time, audio, circle_color);

  gl_FragColor = vec4(color,1.0);
}
