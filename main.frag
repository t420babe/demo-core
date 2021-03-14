// Tarengiri (Abgt407) by Sultan + Sheperd
#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;
uniform float u_at;

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_TRANS
#include "./lib/common/trans.glsl"
#endif

#ifndef T420BABE_ELECTRONS_08
#include "./lib/t420babe/electrons/electrons-08.glsl"
#endif

#ifndef T420BABE_ELECTRONS_02
#include "./lib/t420babe/electrons/electrons-02.glsl"
#endif

#ifndef T420BABE_ELECTRONS_02
#include "./lib/t420babe/electrons/electrons-02.glsl"
#endif

#ifndef T420BABE_ELECTRONS_02
#include "./lib/t420babe/electrons/electrons-02.glsl"
#endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t;
  t = wrap_time(u_at * 1.0, 1.0);

  // color_0 = ele_02(pos, u_at, audio, u_resolution);
  // color_1 = ele_02(pos, u_at, audio, u_resolution);
  // color = mix(color_1, color_0, t);

  color = ele_02(pos, u_at, audio, u_resolution);

  gl_FragColor = vec4(color, 1.0);
}

