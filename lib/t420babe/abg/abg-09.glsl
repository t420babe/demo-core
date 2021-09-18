// Break My Love by Nicolas Jarr
// Neon Jungle - Lane 8 Remix by CloZee, Lane 8 
// Job Jobse set begin
#ifndef T4B_ABG_09
#define T4B_ABG_09

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
  float x = pos.x;
  float y = pos.y;
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

void abg_09(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // pos *= (abs(sin(time * 0.5))) * 500.0;
  // pos *= wrap_time(time, 10.0) + 100.0;
  pos *= wrap_time(time, 100.0);
  // pos *= time;

  // pos *= wrap_time(time, 30.0) + 100.0;


  // pos *= wrap_time(time, 50.0) + (abs(sin(time * 0.1)) * 100.0);
  // pos *= wrap_time(time, 50.0) + 70.0;
  // pos *= wrap_time(time, 120.0);
  // pos *= 500.0;

  vec3 color = vec3(1.0);
  color = make_me_float(pos, time, audio);
  // color = flash_add(color, time, 0.5 * abs(audio.notch));

  color.r *= audio.notch;
  color.g *= audio.bandpass;
  color.b *= audio.lowpass;

  color.r *= 3.0;
  color.g *= 3.0;
  color.b *= 3.0;

  vec2 rot_p = p3.xy;
  rot_p *= rotate2d(time);
  gl_FragColor = vec4(color.brg, 1.0);
  gl_FragColor -= texture2D(u_fb, vec2(rot_p.yx/5.+.5) + vec2(0.001, 0.10)) - 0.002;
  // gl_FragColor -= texture2D(u_fb, vec2(-p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) ;
  // gl_FragColor -= texture2D(u_fb, vec2(abs(tan(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.002;
}
#endif
