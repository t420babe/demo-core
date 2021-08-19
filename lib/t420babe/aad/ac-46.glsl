#ifndef T4B_AC_46
#define T4B_AC_46

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_46(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos *= 5.5;

  float w_time = cos(time);
  // float w_time = log(sin(time));
  color = vec3(1.0, 0.1234, audio.notch);
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_0(pos * w_time, audio.bandpass) / audio.notch;
  float pct2 = circle_0(pos * w_time, audio.bandpass);
	color = vec3(pct * color + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));

  gl_FragColor = vec4(color, 1.0);
}
#endif

