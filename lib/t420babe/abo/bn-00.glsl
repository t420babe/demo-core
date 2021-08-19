#ifndef T4B_BN_00
#define T4B_BN_00

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


// Forked from: https://www.shadertoy.com/view/flSSRt
mat2 r2d(float a) { return mat2(cos(a),sin(a),-sin(a),cos(a)); }

vec3 opRepLim( in vec3 p, in float c, in vec3 l)
{
  // vec3 q = p-c*clamp(round(p/c),-l,l);
  vec3 p_div_c = vec3(float(p/c));
  vec3 q = p-c*clamp(p_div_c,-l,l);
  // vec3 q = p-c*clamp((p/c),-l,l);
  return q;
  //return primitive( q );
}

vec4 map(vec3 p, float time) {
  float pd = 9.;
  //p.z += time*2.1;
  p.z += 0.5;
  float cs = length(p)-0.1;
  p.z -= 0.5;
  p.x += sin(time*0.3)*0.3;
  p.z += sin(time*0.3)*0.4;

  p.xz *= r2d(sin(time*.05)*0.5);
  p.yz *= r2d(cos(time*.07)*0.5);
  //vec3 m = p;
  vec3 o = p;
  float c = length(p);
  p = (fract(p*pd)-0.5)/pd;
  p = abs(p);

  p.xz *= r2d(sin(time*.05)*20.5);

  p.yz *= r2d(cos(time*.07)*0.5);

  //float cs = length(p);
  //p.xz *= r2d(sin(time*1.+c*13.));
  //p.xy *= r2d(sin(c*20+time)*0.2);
  //p = (fract(p*pd)-0.5)/pd;
  //p.xz *= r2d(sin(log(c*3.)-time*0.3)*4.);
  p.xy = vec2(length(p.xy),atan(p.x,p.y));

  //p.y = abs(p.y);
  //p.y *= 8./3.14159;
  //vec3 m = p;
  p.y *= 4./(3.14159*2.);
  p.y = (fract(p.y)-0.5);
  p.y = abs(p.y)-sin(o.z*0.2);

  p.xy = vec2(p.x*sin(p.y),p.x*cos(p.y));

  p = opRepLim(p,0.21,vec3(1.));
  p.xz *= r2d(sin(time*1.+c*13.));
  p = opRepLim(p,0.06,vec3(2.));
  p.xy *= r2d(sin(time*1.)+time);
  vec3 m = p;
  p = opRepLim(p,0.005,vec3((0.5-sin(c*5.5+time)*0.5)*10.));

  float d = length(p)-0.001;
  d = max(d,-(length(o.xy)-0.3+o.z*02.1));
  d = max(d,-(cs));
  return vec4(vec3(m.x,o.z,m.z),d);
}



vec2 RM(vec3 ro, vec3 rd, float time) {
  float dO = 0.;
  float ii = 0.;

  for (int i=0;i<220;i++) {
    vec3 p = ro+rd*dO;
    float dS = map(p, time).w;
    dO += dS*0.5;
    ii += 0.1;
    if (dS < 0.001 || dO > 1000.) {break;}
  }
  return vec2(dO,ii);
}

vec3 mainImage(vec3 p3, float time, peakamp audio, vec4 frag_coord, vec2 u_res) {
  // Normalized pixel coordinates (from 0 to 1)
  vec2 uv = 1.- 2.*frag_coord.xy/u_res.xy;

  // Time varying pixel color
  //vec3 col = 0.5 + 0.5*cos(time+uv.xyx+vec3(0,2,4));

  // Output to screen
  //fragColor = vec4(col,1.0);

  //vec2 uv = -1. + 2. * inData.v_texcoord;
  vec2 R = u_res.xy;
  float ar = R.x/R.y;
  uv.x *= ar;
  vec3 col = vec3(0.);
  float c = length(uv*0.9);
  //uv *= r2d(c*4.+time);
  //uv *= r2d(uv.y*time*.1-time*4.3);
  vec3 ro = vec3(0.,0.,-0.5);
  //ro.z += time*0.2;
  vec3 rd = normalize(vec3(uv,1.));
  vec2 d = RM(ro,rd, time);
  vec3 p = ro+rd*d.x;
  vec3 pm = map(p, time).xyz;
  //col = sin(uv.xyy*39.);
  col = vec3((d.y*0.15)-0.3);
  col = (1.-d.yyy*0.1);
  //col -= d.y*0.3;
  vec3 hsv = vec3(
      sin(sin(pm.x*0.04+time*0.03)*4.)*2.+sin(pm.y*9.+pm.z*150.)*0.31,
      sin(pm.z*300.)*0.5+0.5,
      1.-d.y*0.1-d.x*0.4
      );
  if (d.x > 100.) {
    //hsv.y *= 0.2;
  }
  col = hsv2rgb(hsv);
  return col;
}



void bn_00(vec3 p3, float time, peakamp audio, vec4 frag_coord, vec2 u_res) {
  vec3 color = vec3(1.0);
  // vec2 rhom_p = p3.xy;
  // // rhom_p *= 5.0;
  // // rhom_p.x -= 0.5;
  // // rhom_p *= rotate(rhom_p, p3.x);
  // // rhom_p = rotate2d(sin(time) * 3.14 / 1.0) * p3.xy;
  // rhom_p = rotate2d(time * audio.notch) * p3.xy;
  // float rhombus = rhombus_sdf(rhom_p.xy, 1.0);
  // float hex = hexagon_sdf(rhom_p.xy, 6.0, audio.notch * 10.0);
  // // float bri = step(abs(tan( audio.notch * p3.x * 10. + t) * 0.3 + p3.x * sin(t)), 0.01);
  // // float bri = step(abs(tan( audio.notch * p3.x * 10. + t) * 0.3 + p3.x * sin(t)), 0.01);
  // // float bri = step(tan(rhom_p.x), hex);
  // float bri = sharp(hex);
  // // bri /= sharp(hex) * 2.0;
  // color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);

  color = mainImage(p3, time, audio, frag_coord, u_res);
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy / 2.0 + 0.5) + vec2(0.001, 0.00)) - 0.002;
}

#endif
