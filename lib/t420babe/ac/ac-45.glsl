#ifndef T4B_AC_45
#define T4B_AC_45

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_45(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos *= 5.5;
	float w_time = sin(time);
	// float w_time = log(sin(time));
  color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
  // color = vec3(pct2 * color + color * vec3(0.5));

  gl_FragColor = vec4(color, 1.0);
}
#endif

