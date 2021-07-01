// Break My Love by Nicolas Jarr
#ifndef T4B_TTT_32
#define T4B_TTT_32

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
  pos = pos.yx;
  vec2 pos_rot = rotate2d(sin(time) * 3.14 / 1.0) * pos;

  float x = pos.x * asin(time);
  float y = pos.y * atan(pos.x);

  // float iiTime = time;
  float iiTime = wrap_time(time, t2s(0, 50, 0));
  vec3 color = vec3(0,0,0);
  // float mul = abs(sin(time)) * 0.01;
  float mul = abs(pos.x);
  int v0 = int(abs((y)));
  int v1 = int(abs(2.0 * (x + 100.0)));
  int v2 = int(abs(x));
  int v3 = int(abs(2.0*(y-100.0)));
  int v4 = int(abs((y)));
  int v5 = int(abs(2.0 * (x-100.0)));
  int v6 = int(abs(x));
  int v7 = int(iiTime);
  int v8 = int(abs(atan(y)));
  int v9 = int(iiTime);
  int v10 = int(abs(x));
  int v11 = int(abs(mul *y-iiTime));
  int v12 = int(abs(x));
  int v13 = int(abs(mul *y+iiTime));
  int v14 = int(abs(y));
  int v15 = int(abs(mul *x-iiTime));
  int v16 = int(abs(y));
  int v17 = int(abs(mul *x+iiTime));
  int v18 = int(abs(y));
  int v19 = int(abs(mul * x));
  int v20 = int(abs(x));
  int v21 = int(abs(mul * y));

  if (abs(x / y)>=iiTime+1.0 || abs(tan(y) * x) >= iiTime+1.0) {
    color = vec3(0.1, 1.5, 0.5);
  } else if ( (v0 == v1 ) || (v2 == v3) || (v4 == v5) || (v6 == v7) || (v8 == v9) || (v10 == v11) || (v12 == v13) || (v14 == v15) || (v16 == v17) || (v18 == v19) || (v20 == v21) ) {
    color = vec3(1,1,1);
  }

  return color;
}

void ttt_32(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // pos *= (abs(sin(time * 0.5))) * 500.0;
  pos *= wrap_time(time, 10.0) + 100.0;
  // pos *= 500.0;

  vec3 color = vec3(0.0);
  color = make_me_float(pos, time, audio) + 0.3;
  // color = flash_add(color, time, 0.5 * abs(audio.notch));

  vec3 mix_color = vec3(0.5, 0.1, 0.6);
  vec3 hsv_color = rgb2hsv(color);
  color += 0.05;
  color.r = color.r * (audio.bandpass) * 2.0;
  color.g = color.g * (audio.notch) * 1.0;
  color.b = hsv_color.b * (audio.lowpass) * 2.0;
  // color.g *= color.b * abs(audio.notch) * 1.0;
  // color.g = hsv_color.b * abs(audio.notch) * 1.0;
  // color.b *= abs(audio.highpass) * 1.5;
  // color.b *= abs(sin(time)) - 0.1;
  // color = color.grb;
  // color = color.rbg;
  color = color.grb;
  gl_FragColor = vec4(color, 1.0);
  gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor -= texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - audio.notch * 0.1;
  gl_FragColor -= texture2D(u_fb, vec2(abs(tan(p3.yx/ (PI * 0.60) + PI)) + 0.50) + vec2(0.001, 0.001)) - 0.005;
  gl_FragColor -= texture2D(u_fb, vec2((tan(p3.yx/ (PI))) + 0.50) + vec2(0.001, 0.001)) - 0.005;
}
#endif
