#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef T420BABE_SAYIN_SAYIN
#include "./lib/t420babe/sayin-sayin.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


/* Your Mind - Radio Edit - Adam Beyer, Bart Skils */
/* target qmetro: 60 ms */
void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
    // H, thatsss cool, Losing Your Mind
  sayin_sayin_blue_wiggly_clock_og_4(pos, u_time, audio, color);

  gl_FragColor = vec4(color, 1.0);
}
