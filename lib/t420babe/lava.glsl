#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PERMUTE
#include "./lib/common/permute.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef PXL_RHOMBUS
#include "./lib/pxl/rhombus-sdf.glsl"
#endif

#ifndef PXL_CIRCLE
#include "./lib/pxl/circle-sdf.glsl"
#endif

#ifndef FNC_FLIP
#include "./lib/pxl/flip-sdf.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float snoise(vec2 v) {
  const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
      0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
      -0.577350269189626,  // -1.0 + 2.0 * C.x
      0.024390243902439); // 1.0 / 41.0
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
      + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}


void slow_lava(vec2 pos, out vec3 color) {
  pos *= 3.0;

  float DF = 0.0;

  // Add a random position
  float a = 0.0;
  vec2 vel = vec2(u_time*.1);
  DF += snoise(pos+vel)*.25+.25;

  // Add a random position
  a = snoise(pos*vec2(cos(u_time*0.15),sin(u_time*0.1))*0.1)*3.1415;
  vel = vec2(cos(a),sin(a));
  DF += snoise(pos+vel)*.25+.25;

  float crs = rhombus_sdf(pos, 0.0);
  color = vec3( smoothstep(.7,.75,fract(DF)) );
  color /= sharp(crs);

  // color.r = 1.0 - color.r;
}

// void slow_circle(vec2 pos, peakamp audio, out vec3 color) {
//
//   vec3 circ_color = vec3(0.0);
//   float circ = circle_sdf(pos, 5.0 * audio.bandpass);
//   circ_color.b += sharp(circ);
//
//   slow_lava(pos, color.bgr);
//   color.b = circ_color.b;
// }
void my_mix(peakamp audio, out vec3 color) {
  // vec3 c1 = vec3(0.760704, 0.94902, 0.0);
  vec3 c0 = vec3(0.94902 ,0.0, 0.760704);
  float f = abs(audio.bandpass);
  color = (1.0 - f) * c0 + f * color;
}

void slow_circle_0(vec2 pos, peakamp audio, out vec3 color) {

  vec3 circ_color = vec3(0.0);
  float circ = circle_sdf(pos, 10.0 * audio.bandpass);
  circ_color.b += sharp(circ);
  my_mix(audio, color);
  
  vec3 tmp_color = vec3(0.1, 0.6, 0.1);
  slow_lava(pos, tmp_color);
  color.b /= circ_color.b;
  color.r = tmp_color.b;
}

void slow_circle(vec2 pos, peakamp audio, out vec3 color) {

  vec3 circ_color = vec3(0.0);
  float circ = circle_sdf(pos, 10.0 * audio.bandpass);
  circ_color.b += sharp(circ);
  my_mix(audio, color);
  
  vec3 tmp_color = vec3(1.0);
  slow_lava(pos, tmp_color);
  color.b /= circ_color.b;
  color.r = tmp_color.b;
}

void fast_lava(vec2 pos, peakamp audio, out vec3 color) {
  pos *= 3.0;

  float DF = audio.notch;

  // Add a random position
  float a = 0.0;
  vec2 vel = vec2(u_time*.1);
  DF += snoise(pos+vel)*.25+.25;

  // Add a random position
  a = snoise(pos*vec2(cos(u_time*0.15),sin(u_time*0.1))*0.1)*3.1415;
  vel = vec2(cos(a),sin(a));
  DF += snoise(pos+vel)*.25+.25;

  float crs = rhombus_sdf(pos, 5.0 * audio.bandpass);
  color = vec3( smoothstep(.7,.75,fract(DF)) );
  color /= sharp(crs);

  color.r = 1.0 - color.r;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  slow_circle_0(pos, audio, color);
  // slow_lava(pos, color);

  gl_FragColor = vec4(color, 1.0);
}
