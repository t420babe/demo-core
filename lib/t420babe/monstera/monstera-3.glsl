#ifndef T420BABE_MONSTERA_3
#define T420BABE_MONSTERA_3

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PERMUTE
#include "./lib/common/permute.glsl"
#endif

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

/* BEGIN PXL_CIRCLE*/
#ifndef PXL_CIRCLE
float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}
#endif
/* END PXL_CIRCLE*/

void monstera_audio_circle(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float pct = sharp(circle_1(pos * 0.95, abs(audio.bandpass) * 1.0));
  color = vec3(1.0, pct * abs(sin(u_time)), 1.0);
}

float lava_lamp(vec2 st, float u_time) {
  // vec2 st = gl_FragCoord.xy/u_resolution.xy;
  // st.x *= u_resolution.x/u_resolution.y;
  vec3 color = vec3(0.0);
  vec2 pos = vec2(st*2.5);

  float DF = 0.0;

  // Add a random position
  float a = 0.0;
  vec2 vel = vec2(u_time*.1);
  DF += snoise(pos+vel)*.25+.25;

  // Add a random position
  a = snoise(pos*vec2(cos(u_time*0.15), sin(u_time*0.1))*0.1)*PI;
  vel = vec2(sin(a), cos(a));
  DF += snoise(pos+vel)*.25+.25;

  return ( smoothstep(.7,.75,fract(DF)) );
}
/* BEGIN T420BABE_AUDIO_CIRCLE */

float monstera_hexagon(vec2 pos, float size, float u_time, peakamp audio) {
  pos = abs(pos * 1.0);
  pos /= size;
  float hexagon = 5.0;
  hexagon = (max(abs(pos.y), pos.x * 0.9 + pos.y * (tan(u_time))));
  return hexagon;
}

void monstera_circle(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float pct = sharp(circle_1(pos * 0.95, abs(audio.bandpass) * 1.0));
  color = vec3(1.0, pct * abs(sin(u_time)), 1.0);
}

void monstera_3(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float lava = lava_lamp(pos, u_time);
  color = vec3(0.4, 0.243, 0.0234);
  color /= vec3(lava); 

  vec3 orange_circle = vec3(1.0);
  monstera_circle(pos, u_time, audio, orange_circle);

  // Color 00
  color *= orange_circle.brg * audio.notch * 2.0;
  color.r /= audio.notch;

  // // Color 1
  // color *= orange_circle * audio.notch * 2.0;
  // color.b /= (sharp(monstera_hexagon(pos, 10.0, u_time, audio)));
  // color.b *= audio.notch;

  // // Color 2
  // color *= orange_circle * audio.notch * 2.0;
  // color.r /= (sharp(monstera_hexagon(pos, 10.0, u_time, audio)));
  // color.r *= audio.notch;

  // // Color 3
  // color.r *= orange_circle.b * audio.notch * 2.0;
  // color.b -= (sharp(monstera_hexagon(pos, 10.0, u_time, audio)));
  // color.b *= audio.notch;

  // // Color 4
  // color.b /= orange_circle.g + audio.notch;
  // color.g /= orange_circle.g + audio.lowpass;
  // color.b *= (sharp(monstera_hexagon(pos, 10.0, u_time, audio)));

  // Color 5
  // color += orange_circle * audio.notch * 2.0;
  // color.g += (sharp(monstera_hexagon(pos, 10.0, u_time, audio)));
  // color.g *= audio.notch;
}
#endif
