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
  pos /= 1.1;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(pos * 1.0, 5, tan(u_time));
  // color = gradient_and_sharp_line(pos, pct, DEMO_EASE(u_notch), vec3(0.234, 0.12309, 0.89724 * u_notch), vec3(0.234 * u_notch, 0.987, 0324));
  vec3 color_a = vec3(0.234 * u_notch, 0.987, 0324);
  color /= pct;
  float rect = rectangle(pos, vec2(0.0, 0.0), vec2(0.5));
  color = mix(color, color_a, rect);

  gl_FragColor = vec4(color, 1.0);
}

// autocmd BufWritePost * execute '!git add % && git commit -m %'
