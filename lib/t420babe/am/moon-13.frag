// The Balancer's Name - by Lord Huron
#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
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

float rect_sdf(vec2 st, vec2 s) {
    st = st * 2.0 ;
    return max( fract(abs(st.x / s.x)), fract(abs(s.y / st.y)) );
}


float cross_sdf(vec2 st, float s) {
    vec2 size = vec2(0.50, s * 2.0);
    return min( rect_sdf(st.xy,size.xy),
                rect_sdf(st.xy,size.yx));
}
void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  float cross_shape = cross_sdf(pos * 1.5, 1.0);
  color = vec3(abs(sin(u_time * 0.5)), audio.highpass * 2.0, audio.notch * 2.0);
  color /= vec3(sharp(fract(cross_shape)));
  color *= sharp(fract(cross_shape)) + color * sharp(fract(cross_shape)) - vec3(0.5, 1.0, 0.5);
  // color = 1.5 - color;

  gl_FragColor = vec4(color, 1.0);
}
