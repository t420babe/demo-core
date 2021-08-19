#ifndef T4B_AC_41
#define T4B_AC_41

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_41(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  // pos /= 0.1;
  pos /= rotate_w_offset(pos, 0.0, 4.0);
  pos += 10.0;

  float w_time = sin(time * audio.lowpass * 10.0);
  color = vec3(1.0, 0.3234, audio.lowpass);
  // color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * abs(w_time) * 0.1, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));

  gl_FragColor = vec4(color, 1.0);
}
#endif

