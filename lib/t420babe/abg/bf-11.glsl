// Job Jobse set
// Transcendental Access Point (Mixed) by Eris Drew
#ifndef T4B_TTT_11
#define T4B_TTT_11

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
  vec2 pos_rot = rotate2d(sin(time) * 3.14 / 1.0) * pos;

  float x = pos.x * sin(pos.x);
  float y = pos.y * tan(pos.x);
  // float y = pos.y;
  // float x = cos(pos.x) * abs(audio.notch) * 5.0;
   // x += atan(pos.x + 500.0) * abs(audio.notch) * 20.0;
   // x += atan(pos.x - 500.0) * abs(audio.notch) * 20.0;
   // x += atan(pos.x + 1000.0) * (abs(audio.bandpass) + 0.1)* 100.0;
   // x += atan(pos.x - 1000.0) * (abs(audio.bandpass) + 0.1) * 100.0;
  // y *= (-pos_rot.y + pos_rot.y);

  float mul = 10.0;
  float shift = 100.0;
  float iiTime= time;
  vec3 color = vec3(0.0);
  int v0 = int(abs((y)));
  int v1 = int(abs(mul * (x - shift)));
  int v2 = int(abs(x));
  int v3 = int(abs(mul*(y-shift)));
  int v4 = int(abs((y)));
  int v5 = int(abs(mul*(x-shift)));
  int v6 = int(abs(x));
  int v7 = int(iiTime);
  int v8 = int(abs(tan(y)));
  int v9 = int(iiTime);
  int v10 = int(abs(x));
  int v11 = int(abs(mul*y-iiTime));
  int v12 = int(abs(x));
  int v13 = int(abs(mul*y+iiTime));
  int v14 = int(abs(y));
  int v15 = int(abs(mul*x-iiTime));
  int v16 = int(abs(y));
  int v17 = int(abs(mul*x+iiTime));
  int v18 = int(abs(y));
  int v19 = int(abs(mul*x));
  int v20 = int(abs(y));
  int v21 = int(abs(mul*y));

  if (abs(x)>=iiTime+1.0 || abs(y) >= iiTime+1.0) {
    color = vec3(0,1,0);
  } else if ( (v0 == v1 ) || (v2 == v3) || (v4 == v5) || (v6 == v7) || (v8 == v9) || (v10 == v11) || (v12 == v13) || (v14 == v15) || (v16 == v17) || (v18 == v19) || (v20 == v21) ) {
    color = vec3(1,1,1);
  }

  return color;
}

void ttt_11(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // pos *= (abs(sin(time * 0.5))) * 500.0;
  // pos *= wrap_time(time, 100.0) + 100.0;
  // time += 500.0;
  pos *= time * 3.0;


  vec3 color = vec3(0.5, 0.6, 1.0);
  color = make_me_float(pos, time, audio) + 0.3;
  // color = flash_add(color, time, 0.5 * abs(audio.notch));

  vec3 mix_color = vec3(0.8, 0.9, 0.8);
  vec3 hsv_color = rgb2hsv(color);
  // // color.r = color.b * abs(audio.bandpass) * 1.0;
  // // color.g = color.b * abs(audio.notch) * 1.5;
  // color.r = hsv_color.b * abs(audio.bandpass) * 1.5;
  // // color.g *= color.b * abs(audio.notch) * 1.0;
  // color.g = hsv_color.b * abs(audio.notch) * 1.0;
  // // color.b *= abs(audio.highpass) * 1.5;
  // // color.b *= abs(sin(time)) - 0.1;
  // // color = color.grb;
  // // color = color.rbg;
  // // color = color.brg;
  // // color = color.bgr;
  //
  // color.r *= audio.notch;
  // color.g *= audio.highpass;
  // color.b *= audio.bandpass;

  // color.r *= audio.notch;
  // color.g *= audio.highpass;
  // color.b *= audio.lowpass;

  // color.r *= 2.0;
  // color.g *= 2.0;
  // color.b *= 1.5;
  // color *= mix_color;
  gl_FragColor = vec4(color.gbr, 1.0);
  gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.01) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor = vec4(color.bgr, 1.0);
  gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
}
#endif
