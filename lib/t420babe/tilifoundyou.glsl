#ifndef T420BABE_TILIFOUNDYOU
#define T420BABE_TILIFOUNDYOU

#ifndef COMMON_COMMON
#include "./lib/common/common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

// Choose between 3 `shader_id`s and 2 `color_id`s
void tilifoundyou(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = log(sin(u_time));

  pos *= 4.0;
  int shader_id = 3;
  int color_id = 0;

  if (shader_id == 0) {
    pos *= rotate(pos, 0.0, 4.0);

  } else if (shader_id == 1) {
    pos *= rotate(pos, 0.0, 4.0);
    pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);

  } else if (shader_id == 2) {
    pos *= rotate(pos, 0.0, 4.0);
    pos *= rotate(pos, fract(audio.notch), 4.0);
    pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);

  } else if (shader_id == 3) {
    pos *= rotate(pos, 0.0, 4.0);
    pos *= rotate(pos, fract(audio.notch), 4.0);
    pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
    pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), audio.notch);

  } else {
    pos *= rotate(pos, 0.0, 4.0);
    // pos *= rotate(pos, fract(audio.notch), 4.0);
    pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
    // pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), audio.notch);
  }

  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), audio.bandpass * 5.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.highpass);
  color = vec3(pct * color + color * pct2);

  if (color_id == 0) {
    color = vec3(color.x * audio.highpass, color.y * audio.lowpass, color.z);
  } else if (color_id == 1) {
    color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
  } else {
    color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
  }
}

  // I'm Just Saying
void tilifoundyou_og(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  pos *= rotate(pos, fract(audio.notch), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  // pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), audio.notch);


  // vec3 color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.highpass);
  color = vec3(pct * color + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
  color = vec3(color.x * audio.highpass, color.y * audio.lowpass, color.z);
}

#endif
