#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_TRANSFORM
#include "./lib/common/transform.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform float u_full_min;
uniform float u_full_ave;
uniform float u_full_max;

uniform vec2 u_resolution;
uniform float u_time;

void main() {
  // I'm Just Saying

  // float w_time = sin(u_time);
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));

  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

  // pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  pos *= rotate(pos, fract(u_notch), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  // pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), u_notch);


  // vec3 color = vec3(1.0, 0.1234, abs(tan(u_time)));
  vec3 color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, u_full_ave);
  color = vec3(pct * color + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
  color = vec3(color.x * u_highpass, color.y * u_lowpass, color.z);
  gl_FragColor = vec4(color, 1.0);
}

// autocmd BufWritePost * execute '!git add % && git commit -m %'

