#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON
#include "./lib/common/00-common.glsl"
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
  vec3 color = vec3(0.2, 0.243, 0.0234);

  // float pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  float pct = sharp(circle_1(pos * 1.1, u_notch));
  float pct2 = sharp(triangle_sdf(pos * 1.1* u_notch));
  color = vec3(pct * color + pct + color.gbr);
  // color = vec3(pct + color * pct2 + color.gbr);
  // int num_vesicas = 4.0;
  // for (int i = 0; i < num_vesicas; i++) {
  //   pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  //   color = vec3(pct * color + pct * color);
  // }

  gl_FragColor = vec4(color, 1.0);
}

  // autocmd BufWritePost * execute '!git add % && git commit -m %'
void sayin_sayin_red_fracture(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct=0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, sin(u_time));
	if (mod_time < 1.0) {
	pct = flower_sdf(scale_pos, 1);
	} else if (mod_time < 2.0) {
	pct = flower_sdf(scale_pos, 2);
	} else if (mod_time < 3.0) {
	pct = flower_sdf(scale_pos, 3);
	} else if (mod_time < 4.0) {
	pct = flower_sdf(scale_pos, 4);
	} else if (mod_time < 5.0) {
	pct = flower_sdf(scale_pos, 5);
	} else if (mod_time < 6.0) {
	pct = flower_sdf(scale_pos, 5);
	} else {
	pct = flower_sdf(scale_pos, 10);
	}
  color += sharp(pct);
}

