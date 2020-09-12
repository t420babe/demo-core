#ifndef PULSE_X_MAX
#define PULSE_X_MAX

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

vec2 pulse_x_pos(vec2 pos, float audio_multiplier) {
  pos *=0.50 * audio_multiplier;
  pos *=0.510;
  return pos;
}

float create_x(vec2 pos, float audio_multiplier) {
  float pct = create_line(pos, audio_multiplier);
  vec2 pos_1 = vec2(pos.x, -pos.y);
  pct += create_line(pos_1, audio_multiplier);
  pct = sharp(pct);
  return pct;
}

// RR IDEAS: change pos*=0.050 to 0.010 and stuff
// try to get a slim x burned into retina then switch to zoomed in fat x
void red_x_max(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *=0.50 * audio.notch;

  float pct = create_x(pos, audio.notch);
  color =  0.0+pct *  color + pct * vec3(0.8989, 0.2234, 0.0);
  color.b = color.x * audio.notch * 0.25;
}


// kowabunga! by SuperParka
void pink_purple_x_max(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float audio_multiplier = audio.bandpass;
  pos = pulse_x_pos(pos, audio_multiplier);

  float pct = create_x(pos, audio_multiplier);

  color = 2.0 * audio_multiplier + pct *  color + pct * vec3(0.8989, 0.2234, abs(sin(u_time)));
  color.g = color.x * audio.notch * 0.25;
}

void pink_purple_x_max_oval(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos = pulse_x_pos(pos, audio.bandpass);

  float pct = create_line(pos, audio.highpass);
  vec2 pos_1 = vec2(-pos.x, pos.y);
  pct += create_line(pos_1, audio.notch);
  pct = sharp(pct);

  color = 2.0 * audio.lowpass + pct *  color + pct * vec3(0.8989, 0.2234, 0.0);
  color.g = color.x * audio.notch * 0.25;
}

void x_box(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float audio_multiplier = audio.bandpass;

  vec3 colorA = vec3(0.149,0.141,0.912);
  vec3 colorB = vec3(1.000,0.833,0.224);

  pos *=0.005;
  float pct = plot(pos, pos.x, audio_multiplier * 0.01) * audio_multiplier;

  vec2 pos_1 = vec2(pos.x, -pos.y);
  pct += plot(pos_1, pos.x, audio_multiplier * 0.01) * audio_multiplier;
  pct = sharp(pct);
  color =  0.0+pct *  color + pct * vec3(0.8989, 0.2234, 0.0);
  color.b = color.x * audio_multiplier * 7.25;
}

#endif
