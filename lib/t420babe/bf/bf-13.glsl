// Unconditional by Sonny Fodera
#ifndef T4B_BF_13
#define T4B_BF_13

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
  vec2 pos_rot = rotate2d((time * 1.5)) * pos;

  float x = sin(pos_rot.x);
  float y = pos_rot.y;
  // float y = pos.y;
  // float x = cos(pos.x) * abs(audio.notch) * 5.0;
   // x += atan(pos.x + 500.0) * abs(audio.notch) * 20.0;
   // x += atan(pos.x - 500.0) * abs(audio.notch) * 20.0;
   // x += atan(pos.x + 1000.0) * (abs(audio.bandpass) + 0.1)* 100.0;
   // x += atan(pos.x - 1000.0) * (abs(audio.bandpass) + 0.1) * 100.0;
  // y *= (-pos_rot.y + pos_rot.y);

  float iiTime= time;
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

  if (abs(y)>=iiTime+1.0 || abs(tan(y) * x) >= iiTime+1.0) {
    color = vec3(0.1, 1.5, 0.5);
  } else if ( (v0 == v1 ) || (v2 == v3) || (v4 == v5) || (v6 == v7) || (v8 == v9) || (v10 == v11) || (v12 == v13) || (v14 == v15) || (v16 == v17) || (v18 == v19) || (v20 == v21) ) {
    color = vec3(1,1,1);
  }

  return color;
}

void bf_13(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // pos *= wrap_time(time * PI / 10.0, PI * 15.0) + PI + 15.0;
  pos *= wrap_time(time, PI * 15.0) + PI * 25.0;
  // pos *= time;

  vec3 color = vec3(0.0);
  color = make_me_float(pos, time, audio);
  // color = flash_add(color, time, 0.5 * abs(audio.notch));

  color += 0.05;
  color.r = color.r * audio.bandpass;
  color.b = color.g * audio.notch;

  // color =  (1.0 / (0.1 - color)); // WHITE
  // color =  (0.5 / (0.1 - color)); // WHITE
  color =  (1.0 - (0.1 / color));
  // color =  (1.5 - (0.1 / color));
  // gl_FragColor = vec4(color.gbr, 1.0);
  gl_FragColor = vec4(color.grb, 1.0);
  // gl_FragColor = vec4(color.rbg, 1.0);
  // gl_FragColor = vec4(color.brg, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - audio.notch * 0.1;
  vec2 p_rot = pos * rotate2d(time);
  vec2 p_fb = pos;
  // p_fb.x = -p_rot.x;
  p_fb.x = -p_fb.x;
  gl_FragColor += texture2D(u_fb, vec2(sin(p3.yx/0.50) + 0.50) + vec2(0.001, 0.001)) - 0.005;
  // return (1.0 - color);
  // return rgb2hsv(color * mix_color);
  // return hsv_color;
  // gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(abs(tan(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.005;
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2((sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.000)) ;
  // gl_FragColor -= texture2D(u_fb, vec2((cos(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.000)) - 0.002;
}
#endif
