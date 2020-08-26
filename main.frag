#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON
#include "./lib/common/common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;


uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

  pos.x += 0.5;
  pos.y += 0.50;
  vec3 color = vec3(1.1, 0.1234, 0.34);
  // float pct = aastep(pos.y, -pos.y) / sin(u_time);
  vec2 rot_pos = rotate(pos * 2.5, 0.0, 0.0);
  // float pct = sharp(cross_sdf(rot_pos * sin(u_time), 1.4));
  // float pct = cross_sdf(rotate(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  // pct *= circle_sdf(pos);
  // float pct2 = circle_sdf(pos);
  // float pct = sharp(hexagon_sdf(pos) / 10.0) * u_highpass;
  // pct += sharp(heart_sdf(pos + sin(u_time) * cos(u_time)));
  // pct += heart_sdf(pos);
  float pct = heart_sdf(pos) * u_notch;
  pct = sharp(pct);
  // float pct2 = (hexagon_sdf(pos) / 10.0) * u_highpass;
  float pct2 = (hexagon_sdf(pos) / 1.0);
  // pct2 = 0.5;
  // pct2 *= 2.0;
  color = vec3(pct * color + color.gbr * pct2);
  color.r -= 0.4;
  // color.g -= u_lowpass;

  // float rect = cross_sdf(pos, 0.4);
  // color = vec3(pct * color + color * rect);
  // color = vec3(pct2 * color + color * vec3(0.5));

  gl_FragColor = vec4(color, 1.0);
}

  // autocmd BufWritePost * execute '!git add % && git commit -m %'
