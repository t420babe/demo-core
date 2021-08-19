// #mark
#ifndef T4B_AC_38
#define T4B_AC_38

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_38(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  float w_time = abs(sin(time));
  // float w_time = log(sin(time));


  pos /= 0.1;
  // RRTI: (Transition Idea):
  pos /= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos /= rotate_w_offset(pos, fract(pos.y), 4.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, audio.notch, wrap_time(time, 0.8) - 0.2);
  vec3 color_0 = vec3(0.8, 0.8234, audio.notch);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  gl_FragColor = vec4(color, 1.0);
}
#endif

