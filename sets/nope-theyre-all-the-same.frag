#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float zoom = 2.0;
vec2 offset = vec2(1.0);

float wave_signal(vec2 _pos, float amplitude, float frequency, float phase, float audio_signal) {
  audio_signal = abs(audio_signal);
  float y = amplitude * sin(_pos.x * frequency);
  float t = 0.012 * (u_time * 120.0);
  y += fract(_pos.x * frequency * 1.0 + t * audio_signal * 120.0) * 20.0 + phase;
  y *= amplitude * 0.06;
  return y;
}

float wave(vec2 _pos, float amplitude, float frequency, float phase, float audio_signal) {
  audio_signal = abs(audio_signal);
  float y = amplitude * sin(_pos.x * frequency);
  float t = 0.012 * (u_time * 120.0);
  y += sin(_pos.x * frequency * 2.0 + t * audio_signal * 120.0) * 5.0 + phase;
  y *= amplitude * 0.06;
  return y;
}

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(0.0);
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

  gl_FragColor = vec4(color,1.0);
}
