#ifdef GL_ES
precision mediump float;
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform samplerCube u_cubeMap;

varying vec4 v_position;
varying vec4 v_color;
varying vec3 v_normal;
varying vec2 v_texcoord;

varying vec3 v_reflect;
varying vec3 v_refract;
varying vec3 v_refract_r;
varying vec3 v_refract_b;
varying vec3 v_refract_g;
varying float v_ratio;

void main(void) {
  vec3 color = vec3(1.0);

  vec3 refract_color, reflect_color;
  refract_color.r = vec3(textureCube(u_cubeMap, v_refract_r)).r;
  refract_color.g = vec3(textureCube(u_cubeMap, v_refract_g)).g;
  refract_color.b = vec3(textureCube(u_cubeMap, v_refract_b)).b * u_lowpass * 1.0;

  reflect_color = vec3(textureCube(u_cubeMap, v_reflect));

  color = mix(refract_color, reflect_color, v_ratio);

  gl_FragColor = vec4(color, 1.0);
}
