#ifndef T420BABE_ADDICTED_00
#define T420BABE_ADDICTED_00

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif


// vec2 center = vec2(0.5,0.5);
// float speed = 0.035;
//
// void mainImage( out vec4 fragColor, in vec2 fragCoord )
// {
//     float invAr = iResolution.y / iResolution.x;
//
//     vec2 uv = fragCoord.xy / iResolution.xy;
//
//   vec3 col = vec4(uv,0.5+0.5*sin(iTime),1.0).xyz;
//
//      vec3 texcol;
//
//   float x = (center.x-uv.x);
//   float y = (center.y-uv.y) *invAr;
//
//   //float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
//   float r = -(x*x + y*y);
//   float z = 1.0 + 0.5*sin((r+iTime*speed)/0.013);
//
//   texcol.x = z;
//   texcol.y = z;
//   texcol.z = z;
//
//   fragColor = vec4(col*texcol,1.0);
// }




vec3 addicted_00(vec2 pos, float u_time, peakamp audio, vec2 res) {
  vec2 uv = pos;
  vec3 color = vec3(1.0);

  float mul = 5.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.035;

  // float invAr = (2.0 * res.y) / res.x;
  float invAr = uv.y / uv.x;

  // vec2 uv = fragCoord.xy / iResolution.xy;

  vec3 col = vec4(uv,0.5+0.5*sin(u_time),1.0).xyz;

  vec3 texcol;

  float x = (center.x-uv.x);
  float y = (center.y-uv.y) *invAr;

  //float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
  float r = -(x*x + y*y);
  float z = 1.0 + 0.5*sin((r+u_time*speed)/0.013);

  texcol.x = z;
  texcol.y = z;
  texcol.z = z;
  return color * texcol;
}
#endif
