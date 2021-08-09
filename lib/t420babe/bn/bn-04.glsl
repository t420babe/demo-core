#ifndef T4B_BN_04
#define T4B_BN_04

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_RHOMBUS
#include "lib/pxl/rhombus-sdf.glsl"
#endif

#ifndef PXL_HEXAGON
#include "lib/pxl/hex-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif


vec4 map(vec3 p, float time, peakamp audio) {
  float pd = 9.;
  p.z += 0.5;
  p.z -= 0.5;
  p.x += sin(time*0.3)*0.3;
  p.z += sin(time*0.3)*0.4;

  p.xz *= rotate2d(sin(time*.05)*0.5);
  p.yz *= rotate2d(cos(time*.07)*0.5);
  vec3 o = p;
  float c = length(p);
  p = (fract(p*pd)-0.5)/pd;
  p = abs(p);

  // p.xz *= rotate2d(sin(time*.05)*20.5);

  p.yz *= rotate2d(cos(time*.07)*0.5);

  //p.xz *= rotate2d(sin(time*1.+c*13.));
  //p.xy *= rotate2d(sin(c*20+time)*0.2);
  //p = (fract(p*pd)-0.5)/pd;
  //p.xz *= rotate2d(sin(log(c*3.)-time*0.3)*4.);
  // p.xy = vec2(length(p.xy),atan(p.x,p.y));

  //p.y = abs(p.y);
  //p.y *= 8./3.14159;
  p.y *= 4./(3.14159*2.);
  // p.y = (fract(p.y)-0.5);
  p.y = abs(p.y)-sin(o.z*0.2);

  p.xy = vec2(p.x*sin(p.y),p.x*cos(p.y));

  p.xz *= rotate2d(sin(time*1.+c*13.));
  p.xy *= rotate2d(sin(time*1.)+time);
  vec3 m = p;

  float dot_radius = 0.005;
  // float dot_radius = 0.010 * audio.notch;
  float d = length(p)- dot_radius;
  // d = max(d, length(o.xy) - 3.3);
  float zoom = 2.0;
  d = max(d,-(length(o.xy) - zoom + o.z * 2.1));
  return vec4(vec3(m.x,o.z,m.z),d);
}



vec2 RM(vec3 ro, vec3 rd, float time, peakamp audio) {
  float dO = 0.;
  float ii = 0.;

  for (int i=0;i<100;i++) {
    vec3 p = ro+rd*dO;
    float dS = map(p, time, audio).w;
    dO += dS*0.5;
    ii += 0.1;
    if (dS < 0.001 || dO > 1000.) {break;}
  }
  return vec2(dO,ii);
}


void bn_04(vec3 p3, float time, peakamp audio, vec4 frag_coord, vec2 u_res) {
  vec3 col = vec3(1.0);

  // Normalized pixel coordinates (from 0 to 1)
  vec2 uv = 1.- 2.*frag_coord.xy/u_res.xy;

  // Time varying pixel color
  // col = 0.5 + 0.5*cos(time+uv.xyx+vec3(0,2,4));

  // Output to screen
  // gl_FragColor = vec4(col,1.0);

  // vec2 uv = -1. + 2. * inData.v_texcoord;
  vec2 R = u_res.xy;
  float ar = R.x/R.y;
  uv.x *= ar;
  col = vec3(0.);
  float c = length(uv*0.9);
  //uv *= rotate2d(c*4.+time);
  //uv *= rotate2d(uv.y*time*.1-time*4.3);
  vec3 ro = vec3(0.,0.,-0.5);
  //ro.z += time*0.2;
  vec3 rd = normalize(vec3(uv,1.));
  vec2 d = RM(ro, rd, time, audio);
  vec3 p = ro+rd*d.x;
  vec3 pm = map(p, time, audio).xyz;
  //col = sin(uv.xyy*39.);
  col = vec3((d.y*0.15)-0.3);
  col = (1.-d.yyy*0.1);
  //col -= d.y*0.3;
  // vec3 hsv = vec3(
  //     sin(sin(pm.x*0.04+time*0.03)*4.)*2.+sin(pm.y*9.+pm.z*150.)*0.31,
  //     sin(pm.z*300.)*0.5+0.5,
  //     1.-d.y*0.1-d.x*0.4
  //     );
  // if (d.x > 100.) {
  //   //hsv.y *= 0.2;
  // }
  // col = hsv2rgb(hsv);
  gl_FragColor = vec4(col, 1.0);
}

#endif
