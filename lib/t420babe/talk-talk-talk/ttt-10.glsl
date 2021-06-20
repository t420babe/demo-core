// Job Jobse set
// Transcendental Access Point (Mixed) by Eris Drew
#ifndef T4B_TTT_10
#define T4B_TTT_10

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_POLYGON
#include "lib/pxl/polygon-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

vec3 make_me_float(vec2 pos, float time, peakamp audio) {
  float x = pos.x * tan(pos.y);
  float y = pos.y * tan(pos.x);
  // float y = pos.y;
  // float x = cos(pos.x) * abs(audio.notch) * 5.0;
   // x += atan(pos.x + 500.0) * abs(audio.notch) * 20.0;
   // x += atan(pos.x - 500.0) * abs(audio.notch) * 20.0;
   // x += atan(pos.x + 1000.0) * (abs(audio.bandpass) + 0.1)* 100.0;
   // x += atan(pos.x - 1000.0) * (abs(audio.bandpass) + 0.1) * 100.0;
  // float y = tan(pos.y * pos.x) + x;
  float iiTime= time;
  vec3 color = vec3(0,0,0);
  int v0 = int(abs((y)));
  int v1 = int(abs(2.0 * (x + 100.0)));
  int v2 = int(abs(x));
  int v3 = int(abs(2.0*(y-100.0)));
  int v4 = int(abs((y)));
  int v5 = int(abs(2.0*(x-100.0)));
  int v6 = int(abs(x));
  int v7 = int(iiTime);
  int v8 = int(abs(tan(y)));
  int v9 = int(iiTime);
  int v10 = int(abs(x));
  int v11 = int(abs(2.0*y-iiTime));
  int v12 = int(abs(x));
  int v13 = int(abs(2.0*y+iiTime));
  int v14 = int(abs(y));
  int v15 = int(abs(2.0*x-iiTime));
  int v16 = int(abs(y));
  int v17 = int(abs(2.0*x+iiTime));
  int v18 = int(abs(y));
  int v19 = int(abs(2.0*x));
  int v20 = int(abs(x));
  int v21 = int(abs(2.0*y));

  if (abs(x)>=iiTime+1.0 || abs(y) >= iiTime+1.0) {
    color = vec3(0,1,0);
  } else if ( (v0 == v1 ) || (v2 == v3) || (v4 == v5) || (v6 == v7) || (v8 == v9) || (v10 == v11) || (v12 == v13) || (v14 == v15) || (v16 == v17) || (v18 == v19) || (v20 == v21) ) {
    color = vec3(1,1,1);
  }

  return color;
}

void ttt_10(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // pos *= ((sin(time * 0.1))) * 500.0;
  pos *= wrap_time(time, t2s(0, 1, 6));
  // pos *= wrap_time(time, 10.0) + 100.0;
  // pos *= 500.0;

  vec3 color = vec3(0.5, 0.6, 1.0);
  color = make_me_float(pos, time, audio) + 0.3;
  // color = flash_add(color, time, 0.5 * abs(audio.notch));

  vec3 mix_color = vec3(0.7);
  vec3 hsv_color = rgb2hsv(color);
  color = hsv_color;
  // color.g = hsv_color.r * abs(audio.notch) * 1.0;
  color.r *= audio.bandpass * 2.0;
  color.g *= audio.notch * 2.0;
  color.b *= audio.highpass * 2.0;

  // color /= mix_color;
  // gl_FragColor = vec4(color.brg, 1.0);
  // gl_FragColor = vec4(color.brg, 1.0);
  gl_FragColor = vec4(color.grb, 1.0);
  // if (time > t2s(0, 3, 4)) {
  if (time > t2s(0, 1, 6)) {
      gl_FragColor -= texture2D(u_fb, vec2(p3.yx/5.+.5) + vec2(0.01, 0.01)) - 0.002;
      gl_FragColor += texture2D(u_fb, vec2(abs(atan(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) ;
      gl_FragColor -= texture2D(u_fb, vec2(abs(tan(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.002;
  } else {
    gl_FragColor -= texture2D(u_fb, vec2(abs(tan(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.002;
    // gl_FragColor -= texture2D(u_fb, vec2(p3.yx/5.+.5) + vec2(0.01, 0.01)) - 0.002;
  }
}
#endif
