#ifndef T420BABE_MONSTERA_DELICIOSA
#define T420BABE_MONSTERA_DELICIOSA

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

/* BEGIN BOS_LAVA_LAMP */
#ifndef BOS_LAVA_LAMP

/* BEGIN COMMON_PERMUTE */
#ifndef COMMON_PERMUTE
vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }
#endif
/* END COMMON_PERMUTE */

/* BEGIN COMMON_NOISE */
#ifndef COMMON_NOISE
float snoise(vec2 v) {
  // (3.0-sqrt(3.0))/6.0, 0.5*(sqrt(3.0)-1.0), -1.0 + 2.0 * C.x, 1.0 / 41.0
  const vec4 C = vec4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 )) + i.x + vec3(0.0, i1.x, 1.0 ));

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
#endif
/* END COMMON_NOISE */

float lava_lamp(vec2 pos, float u_time) {
  // pos.x *= u_resolution.x/u_resolution.y;
  vec3 color = vec3(0.0);
  vec2 tmp_pos = vec2(pos*2.5);

  float DF = 0.0;

  // Add a random position
  float a = 0.0;
  vec2 vel = vec2(u_time*.1);
  DF += snoise(tmp_pos+vel)*.25+.25;

  // Add a random position
  a = snoise(tmp_pos*vec2(cos(u_time*0.15), sin(u_time*0.1))*0.1)*PI;
  vel = vec2(sin(a), cos(a));
  DF += snoise(tmp_pos+vel)*.25+.25;

  return ( smoothstep(.7,.75,fract(DF)) );
}
#endif
/* END BOS_LAVA_LAMP */

/* BEGIN T420BABE_AUDIO_CIRCLE */
#ifndef T420BABE_AUDIO_CIRCLE

/* BEGIN PXL_CIRCLE*/
#ifndef PXL_CIRCLE
float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}
#endif
/* END PXL_CIRCLE*/
void orange_circle_bright_purple_bg_2(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float pct = sharp(circle_1(pos * 0.95, abs(audio.bandpass) * 1.0));
  color = vec3(1.0, pct * abs(sin(u_time)), 1.0);
}
#endif
/* BEGIN T420BABE_AUDIO_CIRCLE */

float monstera_hexagon(vec2 pos, float size, peakamp audio) {
  pos = abs(pos * 1.0);
  pos /= size;
  float hexagon = 5.0;
    hexagon = (max(abs(pos.y), pos.x * 0.5 + pos.y * abs(tan((audio.notch) * 3.0))));
  return hexagon;
}

void monstera_deliciosa(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float lava = lava_lamp(pos, u_time);
  color = vec3(0.4, 0.243, 0.7234);
  color += 0.15;
  color -= vec3(lava); 

  vec3 orange_circle = vec3(1.0);
  orange_circle_bright_purple_bg_2(pos, u_time, audio, orange_circle);

  // Color 0: Main
  color.b /= orange_circle.g + audio.notch;
  color.g /= orange_circle.g + audio.lowpass;
  color.b *= (sharp(monstera_hexagon(pos, 10.0, audio)));
  color.b /= audio.bandpass;

  // // Color 1
  // color.r += orange_circle.b + audio.notch;
  // color.g *= orange_circle.r + audio.lowpass;
  // color.b += (sharp(monstera_hexagon(pos, 10.0, audio)));

  // // Color 2
  // color.r *= orange_circle.b + audio.notch;
  // color.g *= orange_circle.r + audio.lowpass;
  // color.b *= (sharp(monstera_hexagon(pos, 10.0, audio)));


  // // Color 3
  // color.g /= (sharp(monstera_hexagon(pos, 10.0, audio)));
  // color.g *= orange_circle.r + audio.lowpass;
  // color.r *= orange_circle.b + audio.notch;
}
#endif
