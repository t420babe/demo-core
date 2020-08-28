#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// My OSC implementation 
uniform float full_min;
uniform float full_max;
uniform float full_ave;
uniform float song_id;


// OSC from Max
uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef COMMON
#include "./lib/common/common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void main() {
  vec3 color = vec3(1.0, u_notch * 2.0, 0.14117647058);
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  float pct=0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, sin(u_time));
  // if (mod_time < 1.0) {
  // pct = flower_sdf(scale_pos, 1);
  // } else if (mod_time < 2.0) {
  // pct = flower_sdf(scale_pos, 2);
  // } else if (mod_time < 3.0) {
  // pct = flower_sdf(scale_pos, 3);
  // } else if (mod_time < 4.0) {
  // pct = flower_sdf(scale_pos, 4);
  // } else if (mod_time < 5.0) {
  // pct = flower_sdf(scale_pos, 5);
  // } else if (mod_time < 6.0) {
  // pct = flower_sdf(scale_pos, 5);
  // } else {
  // pct = flower_sdf(scale_pos, 10);
  // }
  color += sharp(pct);

  gl_FragColor = vec4(color, 1.0);
}

// autocmd BufWritePost * execute '!git add % && git commit -m %'
