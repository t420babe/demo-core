#ifndef T4B_AC_00
#define T4B_AC_00

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

// Choose between 3 `shader_id`s and 2 `color_id`s
void tilifoundyou(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  float w_time = log(sin(time));

  pos *= 4.0;
  int shader_id = 3;
  int color_id = 0;

  if (shader_id == 0) {
    pos *= rotate_w_offset(pos, 0.0, 4.0);

  } else if (shader_id == 1) {
    pos *= rotate_w_offset(pos, 0.0, 4.0);
    pos *= rotate_w_offset(pos, (sin(time))/exp(pos.x), 1.0);

  } else if (shader_id == 2) {
    pos *= rotate_w_offset(pos, 0.0, 4.0);
    pos *= rotate_w_offset(pos, fract(audio.notch), 4.0);
    pos *= rotate_w_offset(pos, (sin(time))/exp(pos.x), 1.0);

  } else if (shader_id == 3) {
    pos *= rotate_w_offset(pos, 0.0, 4.0);
    pos *= rotate_w_offset(pos, fract(audio.notch), 4.0);
    pos *= rotate_w_offset(pos, (sin(time))/exp(pos.x), 1.0);
    pos *= rotate_w_offset(pos, (cos(time))/cos(pos.y * pos.y), audio.notch);

  } else {
    pos *= rotate_w_offset(pos, 0.0, 4.0);
    // pos *= rotate_w_offset(pos, fract(audio.notch), 4.0);
    pos *= rotate_w_offset(pos, (sin(time))/exp(pos.x), 1.0);
    // pos *= rotate_w_offset(pos, (cos(time))/cos(pos.y * pos.y), audio.notch);
  }

  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), audio.bandpass * 5.0, 0.5));

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
  gl_FragColor = vec4(color, 1.0);
}

  // I'm Just Saying
void ac_00(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  float w_time = sin(time);
  // float w_time = log(sin(time));


  // pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  pos *= rotate_w_offset(pos, fract(audio.notch), 4.0);   // then on beat:
  // pos *= rotate_w_offset(pos, (sin(time))/exp(pos.x), 1.0);
  // pos *= rotate_w_offset(pos, (cos(time))/cos(pos.y * pos.y), audio.notch);


  // vec3 color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.highpass);
  color = vec3(pct * color + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
  color = vec3(color.x * audio.highpass, color.y * audio.lowpass, color.z);
  gl_FragColor = vec4(color, 1.0);
}

#endif
