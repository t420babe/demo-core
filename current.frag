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
  vec3 color = vec3(0.2);
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // pos *= 5.5;
  // pos.x += 5.5;
  // pos.y += 2.5;
  // vec2 ratio_pos = ratio_sdf(pos, vec2(0.5 * u_notch, 0.05));
  // float pct = rect_sdf(pos * sin(u_notch), vec2(0.5, 0.5));
  float pct = rays_sdf(pos, 3);
  color = pct * color.gbr + vec3(0.1, 0.4, 0.9) * pct;

  color.r = u_lowpass;

  gl_FragColor = vec4(color, 1.0);
}

  // autocmd BufWritePost * execute '!git add % && git commit -m %'
