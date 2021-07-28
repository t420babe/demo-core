#ifndef T4B_AC_44
#define T4B_AC_44

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_44(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  // pos *= 5.5;
  pos *= rotate_w_offset(pos, 0.5, 0.0);

  float w_time = sin(time);
  // float w_time = log(sin(time));
  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(audio.bandpass, 1.0, audio.bandpass);
  vec3 color_0 = vec3(audio.bandpass, 1.0, audio.notch);
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));

  gl_FragColor = vec4(color, 1.0);
}
#endif

