#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef PXL_TRIANGLE
#include "lib/pxl/triangle-sdf.glsl"
#endif
#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float rhombus_sdf(vec2 st, float size) {
    return max(triangle_0(st), triangle_0(vec2(st.x, 1.0 - st.y))) / size;
}

float rhombus_sdf(vec2 st) {
    return dot(triangle_sdf(st), triangle_sdf(vec2(st.x * audio.bandpass, 0.0 - st.y * audio.bandpass)));
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  pos *= 5.0;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  float rhombus = tan((rhombus_sdf(pos * 1.0)));

  color = vec3(audio.bandpass, abs(tan(u_time * 0.5)), audio.notch);
  color *= rhombus;
  color = fract(color);

  gl_FragColor = vec4(color, 1.0);
}

