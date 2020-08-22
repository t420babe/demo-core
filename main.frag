#ifdef GL_ES
precision mediump float;
#endif

#ifndef ALBERS_IV_1
#include "lib/albers/iv-1.glsl"
#endif
// #define SHARP(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))
#define SHARP(f) smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f))

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;


float rect(in vec2 pos, in vec2 origin, in vec2 dim) {
  vec2 aa = origin - dim / 2.0;
  vec2 bb = 1.0 - (origin + dim / 2.0);

  vec2 onblock = step(aa, pos);
  vec2 offblock = step(bb, 1.0 - pos);
  return onblock.x * onblock.y * offblock.x * offblock.y;

}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

  vec3 color = vec3(0.2);

  vec3 teal = vec3(0.188235, 0.545098, 0.68275);
  vec3 beige = vec3(0.584314, 0.447059, 0.305882);
  vec3 navy = vec3(0.023529, 0.117647, 0.356863);
  vec3 yellow = vec3(0.780392, 0.72549, 0.396078);
  vec3 orange = vec3(0.627451, 0.419608, 0.223529);

  color = mix(orange, yellow, step(-0.4, pos.y));     // Lower orange and middle lower yellow
  color = mix(color, navy, step(0.0, pos.y));         // Middle lower yellow and middle upper navy
  color = mix(color, teal, step(0.4, pos.y));         // Middle upper navy and upper teal


  float r0 = rect(pos, vec2(0.0, 0.5), vec2(0.2));
  color = mix(color, beige, r0);

  float r1 = rect(pos, vec2(0.0, -0.5), vec2(0.2));
  color = mix(color, beige, r1);


  gl_FragColor = vec4(color, 1.0);
}


